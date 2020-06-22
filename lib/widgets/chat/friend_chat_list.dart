import 'package:flutter/material.dart';

import '../../screens/room_chat_screen.dart';

class FriendChatList extends StatefulWidget {
  final String name;
  final String message;
  final String image;
  final String time;

  FriendChatList({
    @required this.name,
    @required this.message,
    @required this.image,
    @required this.time,
  });

  @override
  _FriendChatListState createState() => _FriendChatListState();
}

class _FriendChatListState extends State<FriendChatList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoomChatScreen.routeName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: widget.image.isEmpty
                  ? AssetImage('assets/images/default_avatar.png')
                  : NetworkImage(widget.image),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.name),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
