import 'package:flutter/material.dart';

class Show extends StatefulWidget {
  const Show({Key key}) : super(key: key);

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  // String _animationName = "idle";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      // FlareActor(
      //   "assets/Filip.flr",
      //   alignment: Alignment.center,
      //   fit: BoxFit.contain,
      //   animation: _animationName,
      // ),
      //     ],
      //   ),
      // ),
    );
  }
}
