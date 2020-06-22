import 'package:flutter/material.dart';
import '../rounded_button.dart';

class LoginForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    BuildContext ctx,
  ) userLogin;

  final bool isLoading;

  LoginForm(this.userLogin, this.isLoading);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';

  void _userSubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.userLogin(_userEmail, _userPassword, context);
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
            onSaved: (value) {
              _userPassword = value;
            },
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 12),
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'Forget password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          widget.isLoading
              ? Center(child: CircularProgressIndicator())
              : RoundedButton(
                  'Login',
                  Theme.of(context).primaryColor,
                  _userSubmit,
                ),
          SizedBox(
            height: 24,
          ),
          RaisedButton(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            onPressed: () {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  content: Text('Comming soon'),
                ),
              );
            },
            child: Text('Login with Google Account'),
          )
        ],
      ),
    );
  }
}
