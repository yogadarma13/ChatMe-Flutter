import 'package:flutter/material.dart';

import '../widgets/chat/room_chat_appbar.dart';
import '../widgets/chat/new_message.dart';
import '../widgets/chat/chat_bubble.dart';

class RoomChatScreen extends StatelessWidget {
  static const routeName = '/room-chat';
  
  final List<ChatBubble> list = [
    ChatBubble('Hello ', true, 'tes'),
    ChatBubble('haii', false, 'tes'),
    ChatBubble('heyyy', true, 'tes'),
    ChatBubble('Hello', true, 'tes'),
  ];

  @override
  Widget build(BuildContext context) {
    final String arg = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: RoomChatAppbar(arg),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (ctx, index) => list[index]),
          ),
          NewMesssage()
        ],
      ),
    );
  }
}
