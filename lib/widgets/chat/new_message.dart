import 'package:chat_me/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMesssage extends StatefulWidget {
  final Friend friendData;

  NewMesssage(this.friendData);

  @override
  _NewMesssageState createState() => _NewMesssageState();
}

class _NewMesssageState extends State<NewMesssage> {
  final _inputMessageController = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    final collectionMessages = Firestore.instance.collection('messages');
    try {
      final user = await FirebaseAuth.instance.currentUser();

      final timestamp = Timestamp.now();

      collectionMessages.document(user.uid).setData({'dummy': 'dummy'});

      collectionMessages
          .document(user.uid)
          .collection(widget.friendData.userId)
          .add(
        {
          'message': _enteredMessage,
          'userId': user.uid,
          'createdAt': timestamp,
        },
      );

      collectionMessages
          .document(widget.friendData.userId)
          .setData({'dummy': 'dummy'});

      collectionMessages
          .document(widget.friendData.userId)
          .collection(user.uid)
          .add(
        {
          'message': _enteredMessage,
          'userId': user.uid,
          'createdAt': timestamp,
        },
      );
    } catch (error) {
      print(error);
    }

    print(_enteredMessage);

    _inputMessageController.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _inputMessageController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Type message',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.all(16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: _enteredMessage.trim().isEmpty ? Colors.grey : Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.white,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            ),
          )
        ],
      ),
    );
  }
}
