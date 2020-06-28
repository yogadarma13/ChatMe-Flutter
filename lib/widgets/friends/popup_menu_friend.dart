import 'package:flutter/material.dart';
import '../../screens/add_friend_screen.dart';
import '../../screens/friend_request_screen.dart';

class PopupMenuFriend extends StatelessWidget {
  final void Function(String value, BuildContext ctx) navigateMenuFriend;

  PopupMenuFriend(this.navigateMenuFriend);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: AddFriendScreen.routeName,
          child: Text('Search friend'),
        ),
        PopupMenuItem(
          value: FriendRequestScreen.routeName,
          child: Text('Friend request'),
        ),
      ],
      onSelected: (value) {
        navigateMenuFriend(value, context);
      },
    );
  }
}
