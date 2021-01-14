import 'package:desichatkara/app_screens/registrationScreen/bloc/registraionBloc.dart';
import 'package:desichatkara/app_screens/screens/Login.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/registrationModel.dart';

class SignUp extends StatefulWidget {
  final String phoneNumber;

  const SignUp({Key key, this.phoneNumber}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState(phoneNumber);
}

class _SignUpState extends State<SignUp> {
  final String phoneNumber;

  _SignUpState(this.phoneNumber);

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  RegistraionBloc _registrationBloc = RegistraionBloc();

  SharedPreferences prefs;
  String cartId = "";

  navToAttachList(context) async {
    Future.delayed(Duration.zero, () {
      print("push");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      }));
    });
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    cartId = prefs.getString("cart_id");
    // DeviceID=prefs.getString("device_id");
    // DeviceID="";
  }

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
                        "Sign Up",
                        style: new TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Please SignUp to enjoy Desichatkara Services",
                        style: new TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                    child: TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: Color(0xFFF7F7F7),
                        ),
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
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                    child: TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        //icon: Icon(Icons.favorite),
                        labelText: 'Email ID',
                        labelStyle: TextStyle(
                          color: Color(0xFFF7F7F7),
                        ),
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
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                    child: TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      obscuringCharacter: "*",
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        //icon: Icon(Icons.favorite),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xFFF7F7F7),
                        ),
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
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      obscuringCharacter: "*",
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: Color(0xFFF7F7F7),
                        ),
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
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: MediaQuery.of(context).size.height * .09, bottom: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),

                    // color: Colors.white,
                    height: 50.0,
                    // padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () {
                        if (_nameController.text == "" ||
                            _emailController.text == "" ||
                            _passwordController.text == "" ||
                            _confirmPasswordController.text == "") {
                          Fluttertoast.showToast(
                              msg: "Please Fill All Required Field",
                              fontSize: 16,
                              backgroundColor: Colors.grey[350],
                              textColor: lightThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                        } else if (!EmailValidator.validate(_emailController.text)) {
                          Fluttertoast.showToast(
                              msg: "Please Enter Correct Email ID",
                              fontSize: 16,
                              backgroundColor: Colors.grey[350],
                              textColor: lightThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                        } else if (!(_passwordController.text == _confirmPasswordController.text)) {
                          Fluttertoast.showToast(
                              msg: "Password and Confirm Password Does Not Match",
                              fontSize: 16,
                              backgroundColor: Colors.grey[350],
                              textColor: lightThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                        } else {
                          Map body = {
                            "name": "${_nameController.text}",
                            "email": "${_emailController.text}",
                            "password": "${_passwordController.text}",
                            "confirm_password": "${_confirmPasswordController.text}",
                            "mobile_number": "+91$phoneNumber",
                            "cart_id": "$cartId"
                          };
                          _registrationBloc.Register(body);
                        }
                      },
                      child: StreamBuilder<ApiResponse<RegistrationModel>>(
                        stream: _registrationBloc.registrationStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            switch (snapshot.data.status) {
                              case Status.LOADING:
                                return
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircularProgressIndicator(
                                      backgroundColor: circularBGCol,
                                      strokeWidth: strokeWidth,
                                      valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)),
                                    ],
                                  );
                                break;
                              case Status.COMPLETED:
                                // if (snapshot.data.data.success.name != null)
                                {
                                  print("complete");

                                  if (snapshot.data.data.success != null) {
                                    Fluttertoast.showToast(
                                        msg: "Thank You ${_nameController.text} For Registering With Us",
                                        fontSize: 14,
                                        backgroundColor: Colors.grey[350],
                                        textColor: lightThemeRed,
                                        toastLength: Toast.LENGTH_LONG);

                                    navToAttachList(context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "The Email Id : ${_emailController.text} has Already Been Taken",
                                        fontSize: 12,
                                        backgroundColor: Colors.grey[350],
                                        textColor: lightThemeRed,
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                }
                                break;
                              case Status.ERROR:
                                Fluttertoast.showToast(
                                    msg: "${snapshot.data.message}",
                                    fontSize: 16,
                                    backgroundColor: Colors.grey[350],
                                    textColor: lightThemeRed,
                                    toastLength: Toast.LENGTH_LONG);
                                /*return Error(
                                      errorMessage: snapshot.data.message,
                                    );*/
                                break;
                            }
                          } else if (snapshot.hasError) {
                            print("error");
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Image.asset("images/user.png",height:22.0,width: 22.0,),
                              Text("SignUp", style: new TextStyle(color: Colors.black, fontSize: 14.0)),
                              /* Container(
                         margin: EdgeInsets.only(left:30.0),
                         child: Icon(Icons.arrow_forward))*/
                            ],
                          );
                        },
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