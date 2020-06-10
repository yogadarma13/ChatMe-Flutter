import 'package:flutter/material.dart';

import '../../screens/room_chat_screen.dart';

class ChatList extends StatefulWidget {
  final String userName;
  final String message;
  final String image;
  final String time;

  ChatList({
    @required this.userName,
    @required this.message,
    @required this.image,
    @required this.time,
  });

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
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
              backgroundImage: NetworkImage(widget.image),
              maxRadius: 30,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.userName),
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
