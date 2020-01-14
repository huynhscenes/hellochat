import 'package:flutter/material.dart';
import 'package:hellochat/loginchat.dart';
import 'package:hellochat/services/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'LogginChat',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(
          auth: new Auth()
      ),
    );
  }
}
