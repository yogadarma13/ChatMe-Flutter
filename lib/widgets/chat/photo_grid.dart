import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/friend.dart';
import '../../screens/full_image_screen.dart';

class PhotoGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dataFriend = ModalRoute.of(context).settings.arguments as Friend;
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ct, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final user = userSnapshot.data as FirebaseUser;
        return FutureBuilder(
          future: Firestore.instance
              .collection('messages')
              .document(user.uid)
              .collection(_dataFriend.userId)
              .where('type', isEqualTo: 'image')
              .getDocuments(),
          builder: (ctx, messageSnapshot) {
            if (messageSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final message =
                messageSnapshot.data.documents as List<DocumentSnapshot>;
            return GridView.builder(
              itemCount: message.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  FullImageScreen.routeName,
                  arguments: {
                    'id': message[i].documentID,
                    'imageUrl': message[i]['message'] as String,
                  },
                ),
                child: Hero(
                  tag: message[i].documentID,
                  child: Image.network(
                    message[i]['message'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
