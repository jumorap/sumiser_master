import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sumiser_master/auth.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  LoginPage({this.auth, this.onSignedIn});

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

//final FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email, _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
        } else {
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered in: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    //_formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    //_formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // With help of 'SingleChildScrollView' we can build in place of 'Column'
        // or Container a scrollable layout, giving a beautiful aspect without
        // damage the composition of screen
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButton(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      Text(
          "¡Hola! Ingresa tus datos y el código en pantalla",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
          ),
      ),
      // We build an image into padding because we are building an app that gonna
      // looks in little and big phones, and with various proofs, was find
      // that this is the optimal width, because this class of padding permit
      // build a padding only in horizontal parts
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Image.asset('assets/login_page_image.png'),
      ),

      Text(
        "SUMISER SAS",
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
      TextFormField(
        decoration: InputDecoration(
          // From 'TextFormField' or just 'TextField' we can add images in text boxes
          // giving nice appearance to text fields
          prefixIcon: Icon(Icons.person),
          labelText: 'Email',
        ),
        validator: (value) => value.isEmpty ? 'Ingrese una dirección de correo válida' : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        // From 'TextFormField' or just 'TextField' we can add images in text boxes
        // giving nice appearance to text fields
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: 'Password',
        ),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButton() {
    if (_formType == FormType.login) {
      return <Widget>[
        // 'SizedBox' build a space enter the text fields and the button
        SizedBox(
          height: 15.0,
        ),
        Material(
          child: MaterialButton(
            minWidth: 150.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Ingresar',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: validateAndSave,
            highlightColor: Colors.blueAccent[100],
            color: Colors.blueAccent,
            textColor: Colors.white,
          ),
        ),
        FlatButton(
          child: Text(
            'Create an account',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: moveToRegister,
        )
      ];
    } else{
      return <Widget>[
        // 'SizedBox' build a space enter the text fields and the button
        SizedBox(
          height: 15.0,
        ),
        Material(
          child: MaterialButton(
            minWidth: 150.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Crear cuenta',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: validateAndSave,
            highlightColor: Colors.blueAccent[100],
            color: Colors.blueAccent,
            textColor: Colors.white,
          ),
        ),
        FlatButton(
          child: Text(
            'Have an account? Login',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: moveToLogin,
        )
      ];
    }
  }

}
