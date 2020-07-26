import 'package:flutter/material.dart';
import 'package:sumiser_master/auth.dart';
import 'package:sumiser_master/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;

  HomePage({this.auth});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _HomePage extends State<HomePage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  Widget build(BuildContext context) {
    switch(_authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(auth: widget.auth,);
      case AuthStatus.signedIn:
        return Container(
          child: Text('Welcome'),
        );
    }
    return LoginPage(auth: widget.auth,);
  }
  
}