import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/friends/friends_list.dart';
import '../screens/add_friend_screen.dart';
import '../widgets/friends/popup_action_friend_request.dart';

class FriendRequestScreen extends StatefulWidget {
  static const routeName = '/friend-request-screen';

  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  var _userId;

  void _acceptFriend() async {
    try {
      // await Firestore.instance.document('users').collection()
    } catch (error) {}
  }

  void _declineFriend() async {}

  void _displayDetailFriendRequest(
    String userId,
    String username,
    String imageUrl,
  ) {
    _userId = userId;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: PopupActionFriendRequest(
            username: username,
            imageUrl: imageUrl,
            acceptFriend: _acceptFriend,
            declineFriend: _declineFriend,
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
      body: FriendsList(_displayDetailFriendRequest, false),
    );
  }
}
