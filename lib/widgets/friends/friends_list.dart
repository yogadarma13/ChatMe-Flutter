import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatelessWidget {
  final void Function(String userId, String userName, String imageUrl) eventClickFriend;
  final bool statusFriend;

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
                    final friendData = dataFriendSnapshot.data.documents;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: NetworkImage(
                            friendData[0]['imageUrl']),
                      ),
                      // Kenapa indexnya dibuat 0 karena pada kasus ini stream akan menghasilkan array yg jumlahnya cuma 1 karena ketika
                      // data uid didapatkan maka langsung dimasukan ke list tile setelah itu baru akan dilakukan pencarian untuk uid selanjutnya
                      title: Text(friendData[0]['username']),
                      onTap: () {
                        eventClickFriend(friendData[0]['userId'], friendData[0]['username'], friendData[0]['imageUrl']);
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
