import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/profile/data_profile.dart';
import '../models/user.dart';
import '../widgets/rounded_button.dart';
import './edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {

  void _userLogout() async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, userSnapsot) {
          if (!userSnapsot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = userSnapsot.data as FirebaseUser;
          return FutureBuilder(
            future:
                Firestore.instance.collection('users').document(user.uid).get(),
            builder: (ctx, dataSnapshot) {
              if (!dataSnapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userData =
                  User.fromSnapshot(dataSnapshot.data as DocumentSnapshot);
              return Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, EditProfileScreen.routeName, arguments: userData);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: userData.imageUrl.isEmpty
                            ? AssetImage('assets/images/default_avatar.png')
                            : NetworkImage(userData.imageUrl),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 24, right: 24, top: 10, bottom: 32),
                      child: Text(
                        userData.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            DataProfile(Icons.assignment_ind, 'ID', userData.id),
                            SizedBox(
                              height: 16,
                            ),
                            DataProfile(Icons.phone, 'Phone number',
                                userData.phoneNumber),
                            SizedBox(
                              height: 16,
                            ),
                            DataProfile(Icons.email, 'Email', userData.email),
                            SizedBox(height: 32,),
                            RoundedButton('Logout', Colors.red, _userLogout)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
