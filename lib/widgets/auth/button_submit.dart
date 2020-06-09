import 'package:flutter/material.dart';

class ButtonSubmit extends StatelessWidget {
  final void Function() submit;
  final bool isLogin;

  ButtonSubmit(this.submit, this.isLogin);
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 16),
      onPressed: submit,
      child: Text(isLogin ? 'Masuk' : 'Register'),
    );
  }
}