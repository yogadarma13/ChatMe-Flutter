import 'package:chat_me/models/friend.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/room_chat_appbar.dart';
import '../widgets/chat/new_message.dart';
import '../widgets/chat/messages.dart';
import '../models/friend.dart';

class RoomChatScreen extends StatelessWidget {
  static const routeName = '/room-chat';

  @override
  Widget build(BuildContext context) {
    final _dataFriend = ModalRoute.of(context).settings.arguments as Friend;
    return Scaffold(
      appBar: RoomChatAppbar(_dataFriend),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Messages(_dataFriend),
          ),
          NewMesssage(_dataFriend),
        ],
      ),
    );
  }
}
