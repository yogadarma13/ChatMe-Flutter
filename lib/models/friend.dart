import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  final String userId;
  final String username;
  final String imageUrl;

  Friend.fromSnapshot(DocumentSnapshot snapshot)
      : userId = snapshot['userId'],
        username = snapshot['username'],
        imageUrl = snapshot['imageUrl'];
}
