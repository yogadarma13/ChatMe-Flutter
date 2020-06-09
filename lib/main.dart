import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/chat_screen.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          // if (userSnapshot.connectionState == ConnectionState.waiting) {
          //   return Center(ch)
          // }
          if (userSnapshot.hasData) {
            return ChatScreen();
          }
          return LoginScreen();
        },
      ),
      routes: {
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
      },
    );
  }
}
