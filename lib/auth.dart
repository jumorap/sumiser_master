import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class BaseAuth {
  Future<String> signinEmailPassword(String _email, String _password);
  Future<String> createUserEmailPassword(String _email, String _password);
}

// We use 'BaseAuth' like interface in Auth
class Auth implements BaseAuth{
  Future<String> signinEmailPassword(String _email, String _password) async {
    FirebaseUser user = (await FirebaseAuth.instance
        .signInWithEmailAndPassword(
    email: _email, password: _password)) as FirebaseUser;
    return user.uid;
  }

  Future<String> createUserEmailPassword(String _email, String _password) async {
    FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
    return user.uid;
  }
}