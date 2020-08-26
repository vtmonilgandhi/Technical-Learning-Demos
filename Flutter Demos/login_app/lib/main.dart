import 'package:flutter/material.dart';
import 'package:login_app/ui/CustomLoginForm.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  final appTitle = "Login";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        backgroundColor: Colors.blueGrey,
        body: CustomLoginForm(),
      ),
    );
  }
}
