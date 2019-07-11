import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';

class Userpage extends StatefulWidget {
  final String name;
  final List list;
  Userpage({Key key, this.name, this.list}) : super(key: key);

  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  //List list = [];

  void initState() {
    super.initState();
    print(widget.list);
    //_loadconfig();
  }


  Future _loadconfig() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/config.json");
    final config = json.decode(data);
    for (var i = 0; i < 10; i++) {
      Timer(Duration(seconds: 10), () {
        setState(() {
          widget.list.add(data);
        });
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: widget.list.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                color: Colors.purple,
                child: InkWell(
                  onTap: () => null,
                  child: Container(
                      width: 100,
                      height: 200,
                      child: Center(
                        child: Text(
                          "${widget.list[index]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )),
                ),
              ),
            );
          }),
    );
  }
}
