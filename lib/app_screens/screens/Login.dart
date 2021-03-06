import 'package:desichatkara/app_screens/UserLogin/bloc/LoginBloc.dart';
import 'package:desichatkara/app_screens/UserLogin/model/LoginModel.dart';
import 'package:desichatkara/app_screens/screens/NavigationButton.dart';
import 'package:desichatkara/app_screens/screens/SignUpLogin.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc _loginBloc;
  SharedPreferences prefs;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String DeviceID="";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';


  _register() async {
    //_firebaseMessaging.getToken().then((token) => print(token));
    var tokenFirebase="";
    _firebaseMessaging.getToken().then((token) async {
      tokenFirebase=token;
      print(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("device_id",tokenFirebase);
      DeviceID=tokenFirebase;
      print("sf");
      String device_id = prefs.getString("device_id");
      print(device_id);
    });
  }


  @override
  void initState() {
    super.initState();
    createSharedPref();
    _loginBloc = LoginBloc();
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    // DeviceID=prefs.getString("device_id");
    // DeviceID="";
  }

  Future<void> managedSharedPref(UserLoginResponseModel data) async {
    prefs.setString("coupon_code", "");
    prefs.setString("cart_id", "${data.cartId}");
    print("cart id at login : ${data.cartId}");
    prefs.setString("user_id", "${data.data.id}");
    prefs.setString("name", "${data.data.name}");
    // userName=data.data.n/ame;
    print("${data.data.name}");
    prefs.setBool("user_login", true);
    prefs.setString("email", "${data.data.email}");
    prefs.setString("user_token", "${data.success.token}");
    print(data.success.token);
    print(prefs.getString("user_token"));
    prefs.setString("user_phone", "${data.data.mobileNumber}");
    userLogin = true;
  }

  navToAttachList(context) async {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return NavigationButton();
      }));
    });
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
        body: Container(
            child: ListView(
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
                      "Welcome Back",
                      style: new TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Please login to enjoy Desichatkara services",
                      style: new TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    // maxLength: 20,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.favorite),
                      labelText: 'Your Email ID',
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
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    obscuringCharacter: "*",
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,

                    // maxLength: 20,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.favorite),
                      labelText: 'Password',
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
                  margin: EdgeInsets.only(top: 20.0, left: MediaQuery.of(context).size.width * .64, bottom: 20.0),
                  child: Text(
                    "Forgot Password?",
                    style: new TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      if(emailController.text=="" ||
                          passwordController.text=="")
                      {
                        Fluttertoast.showToast(
                            msg: "Please Fill All Required Field",
                            fontSize: 16,
                            backgroundColor: Colors.orange[100],
                            textColor: lightThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                      }else if(!EmailValidator.validate(emailController.text)){
                        Fluttertoast.showToast(
                            msg: "Please Enter Correct Email ID",
                            fontSize: 16,
                            backgroundColor: Colors.white,
                            textColor: lightThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                      }else{
                        Map body;
                        body = {
                          "email" : "${emailController.text}",
                          "password" : "${passwordController.text}",
                          "deviceid" : "$DeviceID"
                        };
                        _loginBloc.userLogin(body);
                      }

                      print("${emailController.text}");
                      print("${passwordController.text}");

                    },

                    /*Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home()));
                 },*/
                    child: StreamBuilder<ApiResponse<UserLoginResponseModel>>(
                        stream: _loginBloc.userLoginStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            switch (snapshot.data.status) {
                              case Status.LOADING:
                                return CircularProgressIndicator(
                                    backgroundColor: circularBGCol,
                                    strokeWidth: strokeWidth,
                                    valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)
                                );
                                break;

                              case Status.COMPLETED:
                                managedSharedPref(snapshot.data.data);
                                navToAttachList(context);
                                Fluttertoast.showToast(
                                    msg: "Welcome ${snapshot.data.data.data.name}",
                                    fontSize: 16,
                                    backgroundColor: Colors.white,
                                    textColor: lightThemeRed,
                                    toastLength: Toast.LENGTH_LONG);
                                break;
                              case Status.ERROR:
                                Fluttertoast.showToast(
                                    msg: "Please Enter Correct Email ID and Password",
                                    fontSize: 16,
                                    backgroundColor: Colors.white,
                                    textColor: lightThemeRed,
                                    toastLength: Toast.LENGTH_LONG);
                                print("error");
                                break;
                            }
                          }

                          return Container(
                            width: MediaQuery.of(context).size.width * .85,
                            margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white,
                            ),

                            // color: Colors.white,
                            height: 50.0,
                            // padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(child: Text("Continue", style: new TextStyle(color: Colors.black, fontSize: 16.0))),
                          );
                        }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .20, right: MediaQuery.of(context).size.width * .20, top: 35.0),
                  child: Center(
                    child: Row(
                      children: [
                        Text("New to Desichatkara?", style: new TextStyle(color: Colors.white, fontSize: 16.0)),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpLogin()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left:3.0),
                              child: Text("SignUp", style: new TextStyle(color: Colors.yellow[900], fontSize: 16.0)),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}