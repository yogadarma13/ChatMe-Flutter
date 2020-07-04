import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './room_chat_screen.dart';
import '../models/friend.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'New Chat',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search chat...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                // filled itu seperti memberikan background color
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (ctx, userSnap) {
                if (userSnap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                FirebaseUser user = userSnap.data;
                return StreamBuilder(
                  stream: Firestore.instance
                      .collection('messages')
                      .document(user.uid)
                      .snapshots(),
                  builder: (ctx, friendsSnap) {
                    if (friendsSnap.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    DocumentSnapshot data = friendsSnap.data;
                    if (data.exists) {
                      Map<String, dynamic> friendIdChat =
                          friendsSnap.data['users'];
                      return ListView.builder(
                        itemCount: friendIdChat.keys.length,
                        itemBuilder: (ctx, index) => StreamBuilder(
                          stream: Firestore.instance
                              .collection('messages')
                              .document(user.uid)
                              .collection(friendIdChat.keys.elementAt(index))
                              .orderBy('createdAt', descending: true)
                              .limit(1)
                              .snapshots(),
                          builder: (ctx, messageSnap) {
                            if (messageSnap.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            }
                            return StreamBuilder(
                              stream: Firestore.instance
                                  .collection('users')
                                  .document(friendIdChat.keys.elementAt(index))
                                  .snapshots(),
                              builder: (ctx, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                }
                                Friend friendData =
                                    Friend.fromSnapshot(snapshot.data);
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage: friendData.imageUrl.isEmpty
                                        ? AssetImage(
                                            'assets/images/default_avatar.png')
                                        : NetworkImage(friendData.imageUrl),
                                  ),
                                  title: Text(friendData.name),
                                  subtitle: Text(
                                      messageSnap.data.documents[0]['message']),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoomChatScreen.routeName,
                                        arguments: friendData);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Text('No message'),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
