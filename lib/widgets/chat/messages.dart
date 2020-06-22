import 'package:chat_me/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './chat_bubble.dart';

class Messages extends StatelessWidget {
  final Friend friend;

  Messages(this.friend);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final user = snapshot.data as FirebaseUser;
        return StreamBuilder(
          stream: Firestore.instance
              .collection('messages')
              .document(user.uid)
              .collection(friend.userId)
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (ctx, messageSnapshot) {
            if (messageSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final messages =
                messageSnapshot.data.documents as List<DocumentSnapshot>;
            return ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (ctx, index) => ChatBubble(
                messages[index]['message'],
                messages[index]['userId'] == user.uid,
                key: ValueKey(messages[index].documentID),
              ),
            );
          },
        );
      },
    );
  }
}
