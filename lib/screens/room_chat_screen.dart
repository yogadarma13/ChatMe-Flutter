import 'package:flutter/material.dart';
import '../widgets/chat/room_chat_appbar.dart';
import '../widgets/chat/new_message.dart';

class RoomChatScreen extends StatelessWidget {
  static const routeName = '/room-chat';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoomChatAppbar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          NewMesssage()
        ],
      ),
    );
  }
}
