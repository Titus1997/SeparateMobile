import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_separation_ui/ServerHelper.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Separation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(title: 'Drums and Vocals'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}


class _MyLoginPageState extends State<MyLoginPage> with SingleTickerProviderStateMixin{

  File file;
  TextEditingController controller = TextEditingController();

  initState() {
    super.initState();
    //controller.repeat(max: 1, period: Duration(seconds: 3));
  }

  dispose() {
    super.dispose();
  }

  Future<void> sendDrum() async{
    try{
      var response = await ServerHelper.svhelper.getDrum(file);
    }
    catch(e)
    {
      print(e.message());
    }
  }

  Future<void> sendVocals() async{
    try{
      var response = await ServerHelper.svhelper.getVocal(file);
    }
    catch(e)
    {
      print(e.message());
    }
  }

  Future<void> selectFile() async {
    file = await FilePicker.getFile(type: FileType.ANY);
    controller.text =file.path.toString();
  }

  @override
  Widget build(BuildContext context) {


    final getDrumsButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child:  RaisedButton(
            child: Text('Get Drums Audio', style: TextStyle(color: Colors.white)),
            onPressed: () {
              sendDrum();
            },
            color: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
        )
    );
    final getVocalsButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child:  RaisedButton(
            child: Text('Get Vocals Audio', style: TextStyle(color: Colors.white)),
            onPressed: () {
              sendVocals();
            },
            color: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
        )
    );

    final getAudioFile = Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: RaisedButton(
            child: Text('select the audio file', style: TextStyle(color: Colors.white)),
            onPressed: (){ selectFile(); },
            color: Colors.lightGreenAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
        )
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          ),
        ),
        child: Center(
          child: Container(child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
            TextField(
            controller: controller,
          ),
              getAudioFile,
              Center(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    height: 60,
                    width: 60,
                    child: Hero(
                      tag: 'hero',
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 48.0,
                        child: Image.asset('assets/hero.png'),
                      ),
                    )
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 24.0),
              getDrumsButton,
              getVocalsButton
            ],
          ),
          ),
        ),
      ),
    );
  }
}
