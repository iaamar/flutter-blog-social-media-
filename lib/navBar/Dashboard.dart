import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String dropdownValue = 'Recommended';
  List<Map<dynamic, dynamic>> postList = [];
  final posts = FirebaseDatabase.instance.reference().child("Blog_Posts");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: posts.once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    postList.clear();
                    Map<dynamic, dynamic> values = snapshot.data.value;
                    values.forEach((key, values) {
                      postList.add(values);
                      // print(key);
                    });
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: postList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: EdgeInsets.all(20),
                          elevation: 6,
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      postList[index]["name"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 22,
                                        fontFamily: 'Open',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 240,
                                  width: 370,
                                  child: Image.network(
                                    postList[index]["image"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      postList[index]["type"] + " | ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Open',
                                      ),
                                    ),
                                    Text(
                                      postList[index]["language"] + " | ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Open',
                                      ),
                                    ),
                                    Text(
                                      postList[index]["age"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Open',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      postList[index]["day"] + " | ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Open',
                                      ),
                                    ),
                                    Text(
                                      postList[index]["datetime"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Open',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 45,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: Container(
                      height: 50,
                      width: 250,
                      child: LiquidLinearProgressIndicator(
                        value: 0.80,
                        valueColor: AlwaysStoppedAnimation(Colors.blue[500]),
                        borderColor: Colors.white,
                        borderWidth: 5.0,
                        borderRadius: 12.0,
                        direction: Axis.horizontal,
                        center: Text("83%"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
