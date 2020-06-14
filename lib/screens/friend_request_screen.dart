import 'package:flutter/material.dart';

class FriendRequestScreen extends StatelessWidget {
  static const routeName = '/friend-request-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Request'),
      ),
      body: Center(
        child: Text('Friend Request Screen'),
      ),
    );
  }
}