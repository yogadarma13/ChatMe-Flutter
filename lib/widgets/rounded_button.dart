import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String textButton;
  final Color colorButon;
  final void Function() submit;

  RoundedButton(this.textButton, this.colorButon, this.submit);
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 16),
      color: colorButon,
      onPressed: submit,
      child: Text(textButton),
    );
  }
}