import 'package:flutter/material.dart';

class DialogEditProfileImage extends StatelessWidget {
  final Function openCamera;
  final Function openGalery;

  DialogEditProfileImage(this.openCamera, this.openGalery);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Please choose',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 16,
          ),
          FlatButton(
            onPressed: openCamera,
            child: Text('Camera'),
          ),
          FlatButton(
            onPressed: openGalery,
            child: Text('Galery'),
          )
        ],
      ),
    );
  }
}
