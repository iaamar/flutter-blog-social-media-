import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'navBar/Add.dart';
import 'navBar/Assistant.dart';
import 'navBar/Dashboard.dart';
import 'navBar/Show.dart';
import 'navBar/Account.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final tabs = [Dashboard(), Assistant(), Add(), Show(), Account()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      backgroundColor: Colors.grey,
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: Colors.grey,
        buttonBackgroundColor: Colors.grey,
        backgroundColor: Colors.grey,
        height: 50,
        items: <Widget>[
          Icon(Icons.home, size: 25, color: Colors.white),
          Icon(Icons.keyboard_voice, size: 25, color: Colors.white),
          Icon(Icons.add, size: 25, color: Colors.white),
          Icon(Icons.event_seat, size: 25, color: Colors.white),
          Icon(Icons.account_balance, size: 25, color: Colors.white),
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
      ),
    );
  }
}
