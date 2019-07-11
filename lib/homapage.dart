import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebSocketChannel channel;
  TextEditingController controller;
  final List<String> list = [];
  Map<String, dynamic> user;
  double temp = 0;
  double raw_temp = 0;
  double humidy = 0;
  double raw_humidy = 0;
/*
  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://192.168.43.54:81');
    controller = TextEditingController();
    channel.stream.listen((data) {
      setState(() {
        user = jsonDecode(data.toString());
        if (user["temp"][0] != null && user["temp"][1] != null) {
          raw_temp = user["temp"][0] + 0.0;
          temp = (raw_temp * 5) / 100;
          raw_humidy = user["temp"][1] + 0.0;
          humidy = (raw_humidy * 5) / 100;
        }
        print(user["temp"][0]);
        print(temp);
        list.add(data);
      });
    });
    

    _looper();
  }
  */

  void sendData() {
    if (controller.text.isNotEmpty) {
      channel.sink.add(controller.text);
      controller.text = "";
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _looper() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      channel.sink.add("t");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Example'),
        ),
        body: ListView(
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
            //     Center(
            //       child: Container(
            //         width: 100,
            //         height: 100,
            //         //color: Colors.cyan,
            //         margin: EdgeInsets.only(top: 20),
            //         child: Stack(
            //           //margin: EdgeInsets.only(top: 10),
            //           children: <Widget>[
            //             Positioned(
            //               //margin: EdgeInsets.only(top: 20,right: 20),
            //               child: CustomPaint(
            //                 painter: CustomGate(temp),
            //               ),
            //             ),
            //             Positioned(
            //                 left: 30,
            //                 //padding: EdgeInsets.only(top: 50),
            //                 child: Container(
            //                     padding: EdgeInsets.only(top: 60),
            //                     child: Text(
            //                       "$raw_temp C",
            //                       style: TextStyle(
            //                           color: Colors.grey,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: 15),
            //                     )))
            //           ],
            //         ),
            //       ),
            //     ),
            //     Center(
            //       child: Container(
            //         width: 100,
            //         height: 100,
            //         //color: Colors.cyan,
            //         margin: EdgeInsets.only(top: 20),
            //         child: Stack(
            //           //margin: EdgeInsets.only(top: 10),
            //           children: <Widget>[
            //             Positioned(
            //               //margin: EdgeInsets.only(top: 20,right: 20),
            //               child: CustomPaint(
            //                 painter: CustomGate(humidy),
            //               ),
            //             ),
            //             Positioned(
            //                 left: 30,
            //                 //padding: EdgeInsets.only(top: 50),
            //                 child: Container(
            //                     padding: EdgeInsets.only(top: 60),
            //                     child: Text(
            //                       "$raw_humidy %",
            //                       style: TextStyle(
            //                           color: Colors.grey,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: 15),
            //                     )))
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Form(
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: "Send to WebSocket",
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 120,
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: list.map((data) => Text(data)).toList(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Wrap(
          spacing: 20,
          children: <Widget>[
            Container(
              width: 30,
              height: 30,
              child: FloatingActionButton(
                child: Icon(
                  Icons.send,
                  size: 10,
                ),
                onPressed: () {
                  sendData();
                },
              ),
            ),
            Container(
              width: 30,
              height: 30,
              child: FloatingActionButton(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 18,
                ),
                onPressed: () {
                  _looper();
                },
              ),
            ),
          ],
        ));
  }
}

class CustomGate extends CustomPainter {
  double _value = 0.1;
  CustomGate(this._value);
  Rect myRect = const Offset(0, 0) & const Size(100, 100);
  static double _line = 5;
  Paint _basepaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = _line
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  Paint _paintt = Paint()
    ..color = Colors.blue
    ..strokeWidth = _line
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
