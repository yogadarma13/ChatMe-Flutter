import 'dart:io';

import 'package:chat_me/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/rounded_button.dart';
import '../widgets/profile/popup_option_edit_profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile-screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User _userData;
  final _formEditKey = GlobalKey<FormState>();

  var _id = '';
  var _name = '';
  var _phoneNumber = '';

  var _isLoading = false;

  File _image;
  final picker = ImagePicker();

  Future _pickImageFromCamera() async {
    Navigator.pop(context);
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 30);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future _pickImageFromGalery() async {
    Navigator.pop(context);
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 30);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _showOptionsEditProfileImage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: PopupOptionEditProfileImage(
              _pickImageFromCamera, _pickImageFromGalery),
        );
      },
    );
  }

  Future _updateProfile() async {
    final isValid = _formEditKey.currentState.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        _formEditKey.currentState.save();

        var _imageUrl = _userData.imageUrl;
        if (_image != null) {
          final uploadPhotoProfileRef = FirebaseStorage.instance
              .ref()
              .child('user_image_profile')
              .child(_userData.userId + '.jpg');
          await uploadPhotoProfileRef.putFile(_image).onComplete;
          _imageUrl = await uploadPhotoProfileRef.getDownloadURL();
        }

        await Firestore.instance
            .collection('users')
            .document(_userData.userId)
            .updateData({
          'id': _id,
          'name': _name,
          'phoneNumber': _phoneNumber,
          'imageUrl': _imageUrl
        });
      } catch (error) {
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Update profile failed'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      } finally {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _userData = ModalRoute.of(context).settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        // child: Container(
        //   width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: GestureDetector(
                onTap: _showOptionsEditProfileImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _userData.imageUrl.isEmpty && _image == null
                      ? AssetImage('assets/images/default_avatar.png')
                      : _image != null
                          ? FileImage(_image)
                          : NetworkImage(_userData.imageUrl),
                ),
              ),
            ),
            Form(
              key: _formEditKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    initialValue: _userData.id,
                    decoration: InputDecoration(labelText: 'ID'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your ID.';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _id = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData.name,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name.';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _userData.phoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 10) {
                        print(value.length);
                        return 'Please enter a valid phone number.';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _phoneNumber = value;
                    },
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : RoundedButton(
                          'Update profile',
                          Theme.of(context).primaryColor,
                          _updateProfile,
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
