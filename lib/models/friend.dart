import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  final String userId;
  final String name;
  final String imageUrl;

  Friend.fromSnapshot(DocumentSnapshot snapshot)
      : userId = snapshot['userId'],
        name = snapshot['name'],
        imageUrl = snapshot['imageUrl'];
}
