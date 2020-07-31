import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sumiser_master/auth.dart';
import 'package:sumiser_master/pages/login_page.dart';

class HomePage extends StatefulWidget {
  final IconData icon;
  final BaseAuth auth;

  HomePage({this.auth, this.icon});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _HomePage extends State<HomePage> {
  Stream<QuerySnapshot> _theme = Firestore.instance
      .collection('users')
      .document('local')
      .collection('theme')
      .where('Hola', isEqualTo: "hola")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: <Widget>[

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Tema a tratar",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                stream: _theme,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _theme.toString(),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  );
                },

              ),

              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    _theme.toString(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }





/*  AuthStatus _authStatus = AuthStatus.notSignedIn;

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
  */

}