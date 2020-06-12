import 'package:chat_me/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import './friends_screen.dart';
import './chat_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  final _screenOptions = [
    FriendsScreen(),
    ChatScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
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
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      body: _screenOptions[_selectedIndex],
    );
  }
}
