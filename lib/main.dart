import 'package:flutter/material.dart';
import 'package:sumiser_master/auth.dart';
import 'package:sumiser_master/pages/home_page.dart';
import 'package:sumiser_master/pages/login_page.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Sumiser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      /*home: LoginPage(
        auth: Auth(),
      ),*/
    );
  }
}
