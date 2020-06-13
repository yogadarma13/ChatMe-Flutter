import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {
  final Function displayFriendDetail;

  FriendsList(this.displayFriendDetail);
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(userSnapshot.data.uid)
              .collection('friends')
              .where('friendStatus', isEqualTo: true)
              .snapshots(),
          builder: (context, friendSnapshot) {
            if (friendSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final friends = friendSnapshot.data.documents;
            return ListView.builder(
              itemCount: friends.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('users').where('userId', isEqualTo: friends[index]['userId']).snapshots(),
                    builder: (ctx, dataFriendSnapshot) {
                      if (dataFriendSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          child: null,
                        );
                      }
                      print("stream 2");
                      final friendData = dataFriendSnapshot.data.documents;
                      return ListTile(
                        leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: NetworkImage(
                              'https://www.biography.com/.image/t_share/MTM2OTI2NTY2Mjg5NTE2MTI5/justin_bieber_2015_photo_courtesy_dfree_shutterstock_348418241_croppedjpg.jpg'),
                        ),
                        // Kenapa indexnya dibuat 0 karena pada kasus ini stream akan menghasilkan array yg jumlahnya cuma 1 karena ketika
                        // data uid didapatkan maka langsung dimasukan ke list tile setelah itu baru akan dilakukan pencarian untuk uid selanjutnya
                        title: Text(friendData[0]['username']),
                        onTap: () {},
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
