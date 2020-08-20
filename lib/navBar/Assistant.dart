import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Assistant extends StatefulWidget {
  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  String _animationName = "idle";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'How can  Help You ...',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Open'),
            ),
            VStack(
              [
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: FlareActor(
                      "assets/Filip.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      animation: _animationName,
                    ),
                  ),
                ),
              ],
            )
          ]),
    ));
  }
}
