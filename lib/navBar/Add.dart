import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';
import '../MyHomePage.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String _animationName = "idle";

  File sampleImage;
  String name;
  String language;
  String type;
  String age;
  String url;

  final formKey = new GlobalKey<FormState>();

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Blogapp Images");
      Toast.show('Please Wait Until Screen pops Out !', context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.black);
      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url = imageUrl.toString();
      goToDashPage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDay = new DateFormat('EEE');
    var formatTime = new DateFormat('MMM d HH:mm');

    String day = formatDay.format(dbTimeKey);
    String time = 'Posted on ' + formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "image": url,
      "name": name,
      "day": day,
      "datetime": time,
      "age": age,
      "language": language,
      "type": type
    };

    ref.child("Blog_Posts").push().set(data);
  }

  void goToDashPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: sampleImage == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Add Your Post ...',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Open'),
                    ),
                    VStack([
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
                    ]),
                  ],
                )
              : enableUpload(),
        ),
        floatingActionButton: showFab
            ? FloatingActionButton.extended(
                heroTag: 'btn1',
                label: Text('add   '),
                elevation: 7,
                backgroundColor: Colors.green[700],
                icon: Icon(
                  Icons.add,
                ),
                onPressed: getImage,
              )
            : null,
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Image.file(sampleImage, height: 310.0, width: 660.0),
                    Text(
                      'DETAILS',
                      style: TextStyle(
                          fontFamily: 'Open',
                          fontSize: 25,
                          color: Colors.black),
                    ),
                    TextFormField(
                      cursorRadius: Radius.circular(5),
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          decorationColor: Colors.black,
                          fontSize: 20,
                          height: 1.5,
                          color: Colors.black),
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        labelText: 'name',
                        labelStyle:
                            TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      validator: (value) {
                        return value.isEmpty ? 'name is required' : null;
                      },
                      onSaved: (value) {
                        return name = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      autocorrect: true,
                      cursorRadius: Radius.circular(5),
                      autofocus: false,
                      enableSuggestions: true,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.characters,
                      style: TextStyle(
                          fontSize: 20, height: 1.5, color: Colors.black),
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.bookmark, color: Colors.black),
                        labelText: 'type',
                        labelStyle:
                            TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      validator: (value) {
                        return value.isEmpty ? 'type is required' : null;
                      },
                      onSaved: (value) {
                        return type = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      autocorrect: true,
                      cursorRadius: Radius.circular(5),
                      autofocus: false,
                      enableSuggestions: true,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          height: 1.5, fontSize: 20, color: Colors.black),
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.language, color: Colors.black),
                        labelText: 'language',
                        labelStyle:
                            TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      validator: (value) {
                        return value.isEmpty ? 'language is required' : null;
                      },
                      onSaved: (value) {
                        return language = value;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      autocorrect: true,
                      cursorRadius: Radius.circular(5),
                      autofocus: false,
                      enableSuggestions: true,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          height: 1.5, fontSize: 20, color: Colors.black),
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.ac_unit, color: Colors.black),
                        labelText: 'age',
                        labelStyle:
                            TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      validator: (value) {
                        return value.isEmpty ? 'age is required' : null;
                      },
                      onSaved: (value) {
                        return age = 'Age ' + value + '+';
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 250, 10),
                child: FloatingActionButton.extended(
                  heroTag: 'btn2',
                  label: Text('submit'),
                  backgroundColor: Colors.green[700],
                  icon: Icon(
                    Icons.send,
                  ),
                  onPressed: uploadStatusImage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
