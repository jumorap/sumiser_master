import 'package:flutter/material.dart';
import 'package:sumiser_master/auth.dart';
import 'package:sumiser_master/pages/login_page.dart';

void main(){
  runApp(new MyApp());
}

String hi = "";

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Sumiser',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(
        auth: new Auth(),
      ),
    );
  }
}
