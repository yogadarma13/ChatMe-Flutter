import 'package:flutter/material.dart';

import '../widgets/friends/friends_list.dart';
import '../widgets/friends/popup_menu_friend.dart';
import '../widgets/friends/popup_action_friend.dart';
import './room_chat_screen.dart';
import '../models/friend.dart';
// import '../screens/add_friend_screen.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  Friend _friend;

  void _chatFriend() {
    Navigator.pop(context);
    Navigator.pushNamed(context, RoomChatScreen.routeName, arguments: _friend);
  }

  void _profileFriend() async {}

  void _showFriendDetail(Friend friend) async {
    // _user = await FirebaseAuth.instance.currentUser();
    _friend = friend;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: PopupActionFriend(
            name: friend.name,
            imageUrl: friend.imageUrl,
            positiveFunc: _chatFriend,
            negativeFunc: _profileFriend,
            textPositiveButton: 'Chat',
            textNegativeButton: 'Profile',
            colorPositiveButton: Colors.green,
            colorNegativeButton: Theme.of(context).primaryColor,
            // isLoading: null,
          ),
        );
      },
    );
  }

  void _navigateMenuFriend(String route, BuildContext ctx) {
    Navigator.pushNamed(ctx, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Friends',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  PopupMenuFriend(_navigateMenuFriend)
                  // PopupMenuButton(itemBuilder: (context) =>[
                  //   PopupMenuItem(
                  //     // child: Icon(Icons.lis,
                  //   )
                  // ] ,)
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, AddFriendScreen.routeName);
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  //     height: 30,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(30),
                  //       color: Colors.blue[50],
                  //     ),
                  //     child: Row(
                  //       children: <Widget>[
                  //         Icon(
                  //           Icons.add,
                  //           color: Theme.of(context).primaryColor,
                  //           size: 20,
                  //         ),
                  //         SizedBox(
                  //           width: 2,
                  //         ),
                  //         Text(
                  //           'New Friend',
                  //           style: TextStyle(
                  //               fontSize: 14, fontWeight: FontWeight.bold),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, right: 16, left: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search friend...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                // filled itu seperti memberikan background color
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
            ),
          ),
          Expanded(
            child: FriendsList(_showFriendDetail, 1),
          ),
        ],
      ),
    );
  }
}
