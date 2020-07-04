import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/friend.dart';
import './bottom_sheet_file_options.dart';

class NewMesssage extends StatefulWidget {
  final Friend friendData;

  NewMesssage(this.friendData);

  @override
  _NewMesssageState createState() => _NewMesssageState();
}

class _NewMesssageState extends State<NewMesssage> {
  final _inputMessageController = TextEditingController();
  var _enteredMessage = '';
  final picker = ImagePicker();

  Future _pickImageFromCamera() async {
    Navigator.pop(context);
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 30);

    File image = File(pickedFile.path);

    return _sendFile(image);
  }

  Future _pickImageFromGalery() async {
    Navigator.pop(context);
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 30);

    File image = File(pickedFile.path);

    return _sendFile(image);
  }

  Future _sendFile(File image) async {
    var imageId = DateTime.now();
    final collectionMessages = Firestore.instance.collection('messages');
    try {
      final user = await FirebaseAuth.instance.currentUser();

      final sendFileToMeRef = FirebaseStorage.instance
          .ref()
          .child('messages')
          .child(user.uid)
          .child(widget.friendData.userId)
          .child(imageId.toIso8601String() + '.jpg');

      await sendFileToMeRef.putFile(image).onComplete;
      var myImageUrl = await sendFileToMeRef.getDownloadURL();

      final sendFileToFriendRef = FirebaseStorage.instance
          .ref()
          .child('messages')
          .child(widget.friendData.userId)
          .child(user.uid)
          .child(imageId.toIso8601String() + '.jpg');

      await sendFileToFriendRef.putFile(image).onComplete;
      var friendImgeUrl = await sendFileToFriendRef.getDownloadURL();

      final timestamp = Timestamp.now();

      collectionMessages.document(user.uid).setData(
        {
          'users': {widget.friendData.userId: imageId},
        },
      );

      collectionMessages
          .document(user.uid)
          .collection(widget.friendData.userId)
          .add(
        {
          'message': myImageUrl,
          'userId': user.uid,
          'type': 'image',
          'createdAt': timestamp,
        },
      );

      collectionMessages.document(widget.friendData.userId).setData(
        {
          'users': {user.uid: imageId},
        },
      );

      collectionMessages
          .document(widget.friendData.userId)
          .collection(user.uid)
          .add(
        {
          'message': friendImgeUrl,
          'userId': user.uid,
          'type': 'image',
          'createdAt': timestamp,
        },
      );
    } catch (error) {
      print(error);
    }
  }

  void _showMenuSendFile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return BottomSheetFileOptions(
            _pickImageFromCamera, _pickImageFromGalery);
      },
    );
  }

  void _sendMessage() async {
    final collectionMessages = Firestore.instance.collection('messages');
    try {
      final user = await FirebaseAuth.instance.currentUser();

      final timestamp = Timestamp.now();
      final imageId = DateTime.now().millisecondsSinceEpoch;

      collectionMessages.document(user.uid).setData({
        'users': {widget.friendData.userId: imageId},
      }, merge: true);

      collectionMessages
          .document(user.uid)
          .collection(widget.friendData.userId)
          .add(
        {
          'message': _enteredMessage,
          'userId': user.uid,
          'type': 'text',
          'createdAt': timestamp,
        },
      );

      collectionMessages.document(widget.friendData.userId).setData({
        'users': {user.uid: imageId},
      }, merge: true);

      collectionMessages
          .document(widget.friendData.userId)
          .collection(user.uid)
          .add(
        {
          'message': _enteredMessage,
          'userId': user.uid,
          'type': 'text',
          'createdAt': timestamp,
        },
      );
    } catch (error) {
      print(error);
    }

    _inputMessageController.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                _showMenuSendFile(context);
              },
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: TextField(
              controller: _inputMessageController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Type message',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.all(16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: _enteredMessage.trim().isEmpty ? Colors.grey : Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.white,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
