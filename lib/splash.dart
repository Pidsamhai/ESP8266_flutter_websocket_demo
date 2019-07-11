import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:gate/user.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  List list = [];
  void initState() {
    super.initState();
    onloading();
  }

  onloading() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/config.json");
    final config = json.decode(data);
    for (var i = 0; i < 10; i++) {
      list.add(data);
      print(list);
    }
    if (list != null) {
      onDoneLoading();
      print(list);
    }
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Userpage(
              list: list,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.purple),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
