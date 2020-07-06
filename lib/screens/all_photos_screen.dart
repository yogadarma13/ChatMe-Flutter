import 'package:flutter/material.dart';

import '../widgets/chat/photo_grid.dart';

class AllPhotosScreen extends StatelessWidget {

  static const routeName = '/all-photos-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Photos', style: TextStyle(color: Colors.black),),
      ),
      body: PhotoGrid()
    );
  }
}