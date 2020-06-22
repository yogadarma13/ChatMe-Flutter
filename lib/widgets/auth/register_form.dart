import 'package:flutter/material.dart';

import '../rounded_button.dart';

class RegisterForm extends StatefulWidget {
  final void Function(String name, String phoneNumber, String email,
      String password, BuildContext ctx) userRegister;

  final bool isLoading;

  RegisterForm(this.userRegister, this.isLoading);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  var _name = '';
  var _userPhoneNumber = '';
  var _userEmail = '';
  var _userPassword = '';
  var _userConfirmPass = '';

  void _userSubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      if (_userPassword != _userConfirmPass) {
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Password not same'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        return;
      }
      widget.userRegister(
          _name, _userPhoneNumber, _userEmail, _userPassword, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name.';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
            },
            onSaved: (value) {
              _name = value;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            focusNode: _phoneNumberFocusNode,
            decoration: InputDecoration(labelText: 'Phone Number'),
            validator: (value) {
              if (value.isEmpty || value.length < 10) {
                print(value.length);
                return 'Please enter a valid phone number.';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            onSaved: (value) {
              _userPhoneNumber = value;
            },
          ),
          TextFormField(
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            onSaved: (value) {
              _userEmail = value;
            },
          ),
          TextFormField(
            obscureText: true,
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (value) {
              if (value.isEmpty || value.length <= 7) {
                return 'Please enter at least 7 characters.';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
            },
            onSaved: (value) {
              _userPassword = value;
            },
          ),
          TextFormField(
            obscureText: true,
            focusNode: _confirmPasswordFocusNode,
            decoration: InputDecoration(labelText: 'Confirm Password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Repeat your password.';
              }
              return null;
            },
            onSaved: (value) {
              _userConfirmPass = value;
            },
          ),
          SizedBox(
            height: 32,
          ),
          widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : RoundedButton(
                  'Register',
                  Theme.of(context).primaryColor,
                  _userSubmit,
                )
        ],
      ),
    );
  }
}
