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

  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(_authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Scaffold(
          body: Container(
            child: Text('Welcome'),
          ),
        );
    }
    return LoginPage(auth: widget.auth,);
  }
  
}