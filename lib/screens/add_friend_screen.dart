import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddFriendScreen extends StatefulWidget {
  static const routeName = '/add-friend-screen';
  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final _friendIdController = TextEditingController();
  QuerySnapshot _friendData;
  var _isIdValid = false;
  var _isLoading = false;
  var _isLoadingAddFriend = false;

  void _searchFriend(BuildContext ctx) async {
    if (_friendIdController.text.isEmpty) {
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Enter friend's ID"),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        final friendData = await Firestore.instance
            .collection('users')
            .where('id', isEqualTo: _friendIdController.text)
            .getDocuments();
        if (friendData.documents.isNotEmpty) {
          setState(() {
            _isLoading = false;
            _isIdValid = true;
            _friendData = friendData;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } catch (error) {
        print(error);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _addFriend() async {
    setState(() {
      _isLoadingAddFriend = true;
    });
    final user = await FirebaseAuth.instance.currentUser();
    try {
      await Firestore.instance
          .collection('users')
          .document(_friendData.documents[0]['userId'])
          .collection('friends')
          .document(user.uid)
          .setData(
        {
          'friendStatus': 0,
          'userId': user.uid,
        },
      );

      await Firestore.instance
          .collection('users')
          .document(user.uid)
          .collection('friends')
          .document(_friendData.documents[0]['userId'])
          .setData(
        {
          'friendStatus': 1,
          'userId': _friendData.documents[0]['userId'],
        },
      );
    } catch (error) {
      print(error);
    } finally {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Friend',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    onSubmitted: (_) => _searchFriend(context),
                    controller: _friendIdController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Friend's ID",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.blue.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Search'),
                      onPressed: () => _searchFriend(context),
                    ),
                  ),
                ],
              ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                )
              else if (!_isLoading && _isIdValid)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: (_friendData.documents[0]['imageUrl'] as String).isEmpty ? AssetImage('assets/images/default_avatar.png'):
                            NetworkImage(_friendData.documents[0]['imageUrl']),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          _friendData.documents[0]['name'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      _isLoadingAddFriend
                          ? CircularProgressIndicator()
                          : Container(
                              margin: EdgeInsets.only(top: 16),
                              child: RaisedButton(
                                child: Text('Add Friend'),
                                onPressed: _addFriend,
                              ),
                            ),
                    ],
                  ),
                ),
            ],
          )),
    );
  }
}
