import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isMe;
  final String imageUrl;

  ChatBubble(this.message, this.isMe, this.imageUrl);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
        right: widget.isMe ? 16 : 80,
        left: widget.isMe ? 80 : 16
      ),
      child: Align(
        alignment: (widget.isMe) ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(16),
          // color: 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(widget.isMe ? 0 : 20),
              bottomLeft: Radius.circular(widget.isMe ? 20 : 0)
            ),
            color: widget.isMe ? Colors.green : Colors.blue,
          ),
          child: Text(widget.message, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}