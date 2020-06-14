import 'package:flutter/material.dart';
import '../widgets/friends/friends_list.dart';
import '../screens/add_friend_screen.dart';

class FriendRequestScreen extends StatelessWidget {
  static const routeName = '/friend-request-screen';

  void _displayDetailFriendRequest() {}

  void _searchNewFriend(BuildContext ctx) {
    Navigator.pushNamed(ctx, AddFriendScreen.routeName);
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
              _searchNewFriend(context);
            },
          ),
        ],
      ),
      body: FriendsList(_displayDetailFriendRequest, false),
    );
  }
}
