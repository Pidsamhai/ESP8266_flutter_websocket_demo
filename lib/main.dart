import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gate/customgauge.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 208, 0, 255),
          title: Text("Esp8266"),
        ),
        body: Home(),
      ),
    );
  }
}
