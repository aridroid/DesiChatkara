import 'package:desichatkara/app_screens/screens/Login.dart';

import 'package:desichatkara/app_screens/screens/VarificationOtp.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController phoneController = new TextEditingController();
  String ph;

  //FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 15.0, left: 5.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ))),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .10, bottom: 10.0),
                    child: Center(
                      child: Text(
                        "Welcome",
                        style: new TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Please Enter Phone Number to get OTP",
                        style: new TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      maxLength: 10,
                      controller: phoneController,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      // initialValue: '+91',

                      // maxLength: 20,
                      decoration: InputDecoration(
                        //icon: Icon(Icons.favorite),
                        labelText: 'Phone no',
                        labelStyle: TextStyle(
                          color: Color(0xFFF7F7F7),
                        ),
                        //helperText: 'Helper text',

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[900]),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow[900]),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: MediaQuery.of(context).size.height * .09),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),

                    // color: Colors.white,
                    height: 50.0,
                    // padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () {
                        ph = phoneController.text.trim();

                        if(ph.length==10){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationPage(mobileNumber: ph),
                              ));
                        }else{
                          Fluttertoast.showToast(
                              msg: "Enter Proper Phone Number",
                              fontSize: 16,
                              backgroundColor: Colors.white,
                              textColor: lightThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Image.asset("images/user.png",height:22.0,width: 22.0,),
                          Text("Continue", style: new TextStyle(color: Colors.black, fontSize: 14.0)),
                          /* Container(
                         margin: EdgeInsets.only(left:30.0),
                         child: Icon(Icons.arrow_forward))*/
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
