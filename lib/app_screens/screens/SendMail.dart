import 'package:desichatkara/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';


class SendMail extends StatefulWidget {
  @override
  _SendMailState createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'indiasdesichatkara@gmail.com',
  );

  final _subjectController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bodyController = TextEditingController(
    // text: 'your Message.',
  );
  String _body="";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    _body= ("name :  ") + _nameController.text + (",") +("  Phone No :  ")  + _phoneController.text+ (",")  +("  message : ") + _bodyController.text;
    final Email email = Email(
      body: _body,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: darkThemeRed,
          title: Text('Send Mail'),
          actions: <Widget>[
            IconButton(
              onPressed: send,
              icon: Icon(Icons.send),
            )
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
              // CheckboxListTile(
              //   contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              //   title: Text('HTML'),
              //   onChanged: (bool value) {
              //     setState(() {
              //       isHTML = value;
              //     });
              //   },
              //   value: isHTML,
              // ),
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Column(
              //     children: <Widget>[
              //       for (var i = 0; i < attachments.length; i++) Row(
              //         children: <Widget>[
              //           Expanded(
              //             child: Text(
              //               attachments[i],
              //               softWrap: false,
              //               overflow: TextOverflow.fade,
              //             ),
              //           ),
              //           IconButton(
              //             icon: Icon(Icons.remove_circle),
              //             onPressed: () => { _removeAttachment(i) },
              //           )
              //         ],
              //       ),
              //       Align(
              //         alignment: Alignment.centerRight,
              //         child: IconButton(
              //           icon: Icon(Icons.attach_file),
              //           onPressed: _openImagePicker,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      );

  }

  //void _openImagePicker() async {
    // File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
    // if (pick != null) {
    //   setState(() {
    //     attachments.add(pick.path);
    //   });
    // }
  //}

  // void _removeAttachment(int index) {
  //   setState(() {
  //     attachments.removeAt(index);
  //   });
  // }
}