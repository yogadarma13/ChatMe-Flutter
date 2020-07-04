import 'package:flutter/material.dart';

import '../../screens/full_image_screen.dart';

class ChatBubble extends StatelessWidget {
  final String docId;
  final String message;
  final String type;
  final bool isMe;
  final Key key;

  ChatBubble(this.docId, this.message, this.type, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 8, bottom: 8, right: isMe ? 16 : 80, left: isMe ? 80 : 16),
      child: Align(
        alignment: (isMe) ? Alignment.topRight : Alignment.topLeft,
        child: type == 'text'
            ? Container(
                padding: EdgeInsets.all(16),
                // color:
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(isMe ? 0 : 20),
                      bottomLeft: Radius.circular(isMe ? 20 : 0)),
                  color: isMe ? Colors.green : Colors.blue,
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                height: 240,
                width: 192,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, FullImageScreen.routeName, arguments: {'id': docId, 'imageUrl': message}),
                    child: Hero(
                      tag: docId,
                      child: FadeInImage(
                        placeholder:
                            AssetImage('assets/images/default_avatar.png'),
                        image: NetworkImage(message),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
