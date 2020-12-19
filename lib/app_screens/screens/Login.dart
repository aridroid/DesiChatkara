import 'package:desichatkara/app_screens/UserLogin/bloc/LoginBloc.dart';
import 'package:desichatkara/app_screens/UserLogin/model/LoginModel.dart';
import 'package:desichatkara/app_screens/screens/Home.dart';
import 'package:desichatkara/app_screens/screens/SignUpLogin.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc _loginBloc;
  SharedPreferences prefs;

  TextEditingController emailOrPhoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
    prefs.setString("user_id", "${data.data.id}");
    prefs.setString("name", "${data.data.name}");
    // userName=data.data.name;
    print("${data.data.name}");
    prefs.setBool("user_login", true);
    prefs.setString("email", "${data.data.email}");
    prefs.setString("user_token", "${data.success.token}");
    prefs.setString("user_phone", "${data.data.mobileNumber}");
    userLogin=true;
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
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    initialValue: '+91',

                    // maxLength: 20,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.favorite),
                      labelText: 'Email or Phone no',
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
                      Map body = {"email": "sibasis@inceptorytech.zzzzzzz", "password": "123456", "deviceid": "7465"};
                      _loginBloc.userLogin(body);
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
                                Container(
                                  height: 10.0,
                                  width: 10.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                                  ),
                                );

                                break;

                              case Status.COMPLETED:
                                managedSharedPref(snapshot.data.data);
                                Future.delayed(Duration(seconds: 1), () async {
                                  // prefs = await SharedPreferences.getInstance();
                                  prefs.setString("useriddesichatkara", snapshot.data.data.data.id.toString());
                                  print(snapshot.data.data.data.id.toString());
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                    return Home();
                                  }));
                                });
                                break;
                              case Status.ERROR:
                                print("error");
                                break;
                            }
                          }

                          return Container(
                            width: MediaQuery.of(context).size.width * .85,
                            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 12.0),
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
                            child: Text("SignUp", style: new TextStyle(color: Colors.yellow[900], fontSize: 16.0)))
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
