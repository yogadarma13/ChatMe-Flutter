import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/main_screen.dart';
import './screens/room_chat_screen.dart';
import './screens/add_friend_screen.dart';
import './screens/friend_request_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/full_image_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Me',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        accentColor: Colors.orange,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.black), color: Colors.white),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          // if (userSnapshot.connectionState == ConnectionState.waiting) {
          //   return Center(ch)
          // }
          if (userSnapshot.hasData) {
            return MainScreen();
          }
          return LoginScreen();
        },
      ),
      routes: {
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        RoomChatScreen.routeName: (ctx) => RoomChatScreen(),
        AddFriendScreen.routeName: (ctx) => AddFriendScreen(),
        FriendRequestScreen.routeName: (ctx) => FriendRequestScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
        FullImageScreen.routeName: (ctx) => FullImageScreen()
      },
    );
  }
}
