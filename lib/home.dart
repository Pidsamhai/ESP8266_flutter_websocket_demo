import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gate/customgauge.dart';
import 'package:gate/splash.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color _purple = Color.fromARGB(255, 208, 0, 255);
  Color _purple_accent = Color.fromARGB(255, 230, 0, 255);
  final _ip = TextEditingController();
  final _name = TextEditingController();
  Timer time;
  bool state = true;
  double _temp = 0;
  @override
  void dispose() {
    super.dispose();
    state = false;
  }
  void setnum() {
    time = Timer.periodic(Duration(seconds: 3), (t) {
      var rnd = Random();
      double rand = rnd.nextDouble();
      double scaled = rand * 99.9;
      print(scaled);
      setState(() {
        _temp = scaled;
      });
      if(!state){
        t.cancel();
      }
    });
  }
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GaugeWidget(
                fontsize: 50,
                size: 200,
                strokewidth: 20,
                fontColor: Colors.purple,
                text: "50%",
                value: 50,
              ),
              GaugeWidget(
                size: 200,
                fontsize: 30,
                strokewidth: 20,
                text: "${_temp.toStringAsFixed(_temp.truncateToDouble() == _temp ? 0 : 2)} °C",
                fontColor: Colors.purple,
                value: _temp,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            style: TextStyle(color: _purple),
            controller: _name,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Color.fromARGB(90, 230, 0, 255)),
              labelStyle:
                  TextStyle(color: _purple_accent, fontWeight: FontWeight.bold),
              labelText: "Name",
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _purple_accent, width: 2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _purple_accent, width: 2)),
            ),
            cursorColor: _purple,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
          child: TextFormField(
            style: TextStyle(color: _purple_accent),
            controller: _ip,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Color.fromARGB(100, 230, 0, 255)),
                labelStyle: TextStyle(
                    color: _purple_accent, fontWeight: FontWeight.bold),
                labelText: "IP",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _purple_accent, width: 2)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _purple_accent, width: 2)),
                hintText: "Example 192.168.42.54"),
            cursorColor: _purple,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: RaisedButton(
                  child: Text("Clear"),
                  color: _purple_accent,
                  onPressed: () {
                    state = true;
                    setnum();
                    // setState(() {
                    //   _temp = double.parse(_ip.text);
                    // });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 50),
              child: RaisedButton(
                child: Text("Save"),
                color: _purple_accent,
                onPressed: () {
                  state = false;
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           SplashScreen()), //Userpage(name: "Test pass data",)),
                  // );
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
