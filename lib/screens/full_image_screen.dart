import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  static const routeName = '/full-image-screen';

  @override
  Widget build(BuildContext context) {
    final image =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Hero(
            tag: image['id'],
            child: Image.network(
              image['imageUrl'],
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
