import 'package:flutter/material.dart';

import '../rounded_button.dart';

class RegisterForm extends StatefulWidget {
  final void Function(String username, String phoneNumber, String email,
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

  var _username = '';
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
            content: Text('Password tidak sama'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        return;
      }
      widget.userRegister(
          _username, _userPhoneNumber, _userEmail, _userPassword, context);
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
            decoration: InputDecoration(labelText: 'Nama'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Masukkan nama anda';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
            },
            onSaved: (value) {
              _username = value;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            focusNode: _phoneNumberFocusNode,
            decoration: InputDecoration(labelText: 'No Telephone'),
            validator: (value) {
              if (value.isEmpty || value.length <= 10) {
                return 'Masukkan no telephone yang valid';
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
                return 'Masukkan email yang valid';
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
                return 'Masukkan password minimal 7 karakter';
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
            decoration: InputDecoration(labelText: 'Ulangi Password'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Ulangi password anda';
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
