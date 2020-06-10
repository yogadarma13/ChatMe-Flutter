import 'package:flutter/material.dart';
import './chat_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Friends'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
        currentIndex: 1,
      ),
      body: ChatScreen(),
    );
  }
}
