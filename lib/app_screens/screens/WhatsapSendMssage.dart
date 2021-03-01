import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class Whatsaap extends StatefulWidget {
  @override
  _WhatsaapState createState() => _WhatsaapState();
}

class _WhatsaapState extends State<Whatsaap> {
  String _platformVersion = 'Unknown';

  final _subjectController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bodyController = TextEditingController(
    // text: 'your Message.',
  );
  String _body="";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: darkThemeRed,
        title: Text('Send Message'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              _body= ("Name :  ") + _nameController.text + (",") +("  Phone No :  ")  + _phoneController.text+ (",") +("  Subject :  ")  + _subjectController.text+ (",")  +("  message : ") + _bodyController.text;
               FlutterOpenWhatsapp.sendSingleMessage("918135865653", _body);
    },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Get In Touch",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Phone',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      labelText: 'Message', border: OutlineInputBorder()),
                ),
              ),
            ),

          ],
        ),
      ),
    );

      // Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Plugin example app'),
      //   ),
      //   body: Center(
      //       child: MaterialButton(
      //         color: Colors.red,
      //         onPressed: (){
      //           FlutterOpenWhatsapp.sendSingleMessage("918768756317", "Hello");
      //         },
      //         child: Text('send '//$_platformVersion\n''
      //         ),
      //       )
      //   ),
      // );

  }
}