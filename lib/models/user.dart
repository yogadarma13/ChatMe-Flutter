import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String imageUrl;
  final String userId;

  User.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot['id'],
        name = snapshot['name'],
        phoneNumber = snapshot['phoneNumber'],
        email = snapshot['email'],
        imageUrl = snapshot['imageUrl'],
        userId = snapshot['userId'];
}
