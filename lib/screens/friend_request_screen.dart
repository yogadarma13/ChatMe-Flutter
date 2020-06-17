import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/friends/friends_list.dart';
import '../screens/add_friend_screen.dart';
import '../widgets/friends/popup_action_friend.dart';

import '../models/friend.dart';

class FriendRequestScreen extends StatefulWidget {
  static const routeName = '/friend-request-screen';

  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  Friend _friend;
  FirebaseUser _user;

  void _acceptFriend() async {
    // try {
    await Firestore.instance
        .collection('users')
        .document(_user.uid)
        .collection('friends')
        .document(_friend.userId)
        .updateData(
          {
            'friendStatus': 1,
          },
        )
        .then(
          (_) => Navigator.pop(context),
        )
        .catchError(
          (error) {
            print(error);
            Navigator.pop(context);
          },
        );
    // } catch (error) {}
  }

  void _declineFriend() async {
    await Firestore.instance
        .collection('users')
        .document(_user.uid)
        .collection('friends')
        .document(_friend.userId)
        .updateData(
          {
            'friendStatus': 2,
          },
        )
        .then(
          (_) => Navigator.pop(context),
        )
        .catchError(
          (error) {
            print(error);
            Navigator.pop(context);
          },
        );
  }

  void _displayDetailFriendRequest(Friend friend) async {
    _user = await FirebaseAuth.instance.currentUser();
    _friend = friend;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: PopupActionFriend(
            username: friend.username,
            imageUrl: friend.imageUrl,
            positiveFunc: _acceptFriend,
            negativeFunc: _declineFriend,
            textPositiveButton: 'Accept',
            textNegativeButton: 'Decline',
            colorPositiveButton: Colors.green,
            colorNegativeButton: Colors.red,
            // isLoading: null,
          ),
        );
      },
    );
  }

  void _searchNewFriend() {
    Navigator.pushNamed(context, AddFriendScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Friend Request',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              _searchNewFriend();
            },
          ),
        ],
      ),
      body: FriendsList(_displayDetailFriendRequest, 0),
    );
  }
}
