import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/register_form.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _userRegister(
    String username,
    String phoneNumber,
    String email,
    String password,
    BuildContext ctx,
  ) async {
    AuthResult authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData(
        {
          'username': username,
          'email': email,
          'phone_number': phoneNumber,
        },
      );
      return Navigator.pop(context);
    } on PlatformException catch (error) {
      var message = 'Pembuatan akun gagal';

      if (error.message != null) {
        message = error.message;
      }

      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
              SizedBox(
                height: 28,
              ),
              RegisterForm(_userRegister, _isLoading),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Sudah punya akun?'),
                  FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Login'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
