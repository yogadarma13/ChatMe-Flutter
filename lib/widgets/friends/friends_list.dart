import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/friend.dart';

class FriendsList extends StatelessWidget {
  final void Function(Friend friend) eventClickFriend;
  final int statusFriend;

  FriendsList(this.eventClickFriend, this.statusFriend);

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
              .where('friendStatus', isEqualTo: statusFriend)
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
                return StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .where('userId', isEqualTo: friends[index]['userId'])
                      .snapshots(),
                  builder: (ctx, dataFriendSnapshot) {
                    if (dataFriendSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                        child: null,
                      );
                    }
                    print("stream 2");
                    final dataFriend = Friend.fromSnapshot(
                        dataFriendSnapshot.data.documents[0]);
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: dataFriend.imageUrl.isEmpty
                            ? AssetImage('assets/images/default_avatar.png')
                            : NetworkImage(dataFriend.imageUrl),
                      ),
                      // Kenapa indexnya dibuat 0 karena pada kasus ini stream akan menghasilkan array yg jumlahnya cuma 1 karena ketika
                      // data uid didapatkan maka langsung dimasukan ke list tile setelah itu baru akan dilakukan pencarian untuk uid selanjutnya
                      title: Text(dataFriend.name),
                      onTap: () {
                        eventClickFriend(dataFriend);
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
