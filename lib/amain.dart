import 'dart:async';

import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Mygate() //MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Mygate extends StatefulWidget {
  Mygate({Key key}) : super(key: key);

  _MygateState createState() => _MygateState();
}

class _MygateState extends State<Mygate> {
  bool _flag = true;
  double _val = 0;
  void _incremantVal() {
    setState(() {
      _val += 0.01;
      print(_val);
    });
  }

  void _uncremantVal() {
    setState(() {
      _val -= 0.01;
      print(_val);
    });
  }

  /*


*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                width: 200,
                height: 200,
                child: CustomPaint(
                  painter: CustomGate(_val),
                ),
              ),
            ),
            Row(children: <Widget>[
              RaisedButton(
                child: Text("add Val"),
                onPressed: () {
                  _incremantVal();
                },
              ),
              RaisedButton(
                child: Text("Click"),
                onPressed: () {
                  Timer.periodic(Duration(milliseconds: 2), (timer) {
                    if (_val < 5 && _flag == true) {
                      if (_val + 0.01 >= 5) {
                        _flag = false;
                      }
                      _incremantVal();
                    } else if (_flag == false) {
                      if (_val - 0.01 <= 0) {
                        _flag = true;
                      }
                      _uncremantVal();
                    }
                  });
                },
              ),
              RaisedButton(
                child: Text("Click"),
                onPressed: () {},
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class CustomGate extends CustomPainter {
  double _value = 0.1;
  CustomGate(this._value);
  Rect myRect = const Offset(0, 0) & const Size(200, 200);
  Paint _basepaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 13
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  Paint _paintt = Paint()
    ..color = Colors.pink
    ..strokeWidth = 13
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  void paint(Canvas canvas, Size size) {
    canvas.drawArc(myRect, 90.15, 5, false, _basepaint);
    canvas.drawArc(myRect, 90.15, _value, false, _paintt);
  }

  @override
  bool shouldRepaint(CustomGate oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(CustomGate oldDelegate) => true;
}
