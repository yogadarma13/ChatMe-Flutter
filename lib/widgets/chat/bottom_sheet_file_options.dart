import 'package:flutter/material.dart';

class BottomSheetFileOptions extends StatelessWidget {
  final Function openCamera;
  final Function openGalery;

  BottomSheetFileOptions(this.openCamera, this.openGalery);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Send File',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
