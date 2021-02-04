//import 'package:desichatkara/app_screens/registrationScreen/SignUp.dart';
import 'package:desichatkara/app_screens/LoginWithPhone/LoginWithPhoneBloc.dart';
import 'package:desichatkara/app_screens/LoginWithPhone/LoginWithPhoneModel.dart';
import 'package:desichatkara/app_screens/profile_screen/bloc/profileUpdateBloc.dart';
import 'package:desichatkara/app_screens/profile_screen/model/profileUpdateModel.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'NavigationButton.dart';
import 'Otp.dart';
import 'dart:io';

class VerificationPageLogin extends StatefulWidget {
  String mobileNumber;
  final bool socialLogin;


  VerificationPageLogin({this.mobileNumber,this.socialLogin}) {
    print("Mobile Number:" + mobileNumber);
  }

  @override
  _VerificationPageLoginState createState() => _VerificationPageLoginState();
}

class _VerificationPageLoginState extends State<VerificationPageLogin> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  ProfileUpdateBloc _profileUpdateBloc;
  bool updateCheck=false;
  String userName="";
  String userEmail="";

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationCode;
  RaisedButton button;
  String appSignature;
  LoginWithPhoneBloc _loginWithPhoneBloc;
  String DeviceID="";
  SharedPreferences prefs;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() async {
    var tokenFirebase="";
    _firebaseMessaging.getToken().then((token) async {
      tokenFirebase=token;
      print(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("device_id",tokenFirebase);
      DeviceID=tokenFirebase;
      print(DeviceID);
      print("sf");
      String device_id = prefs.getString("device_id");
      print(device_id);
    });
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userName=prefs.getString("name");
    userEmail=prefs.getString("email");


  }

  Future<void> managedSharedPref(LoginWithPhoneModel data) async {
    prefs.setString("coupon_code", "");
    prefs.setString("cart_id", "${data.cartId}");
    print("cart id at login : ${data.cartId}");
    prefs.setString("user_id", "${data.data.id}");
    //prefs.setString("name", "${data.data.name}");
    // userName=data.data.n/ame;
    //print("${data.data.name}");
    prefs.setBool("user_login", true);
    //prefs.setString("email", "${data.data.email}");
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


  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: lightThemeRed),
      borderRadius: BorderRadius.circular(15.0),
    );
  }


  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.mobileNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {

          User user = (await _auth.signInWithCredential(credential)).user;

          if (user != null) {
            var token = await user.getIdToken();
            login();
            // print("token ---- : $token");
            // var response = await httpClient.get(url,headers: {'Authorization':"Bearer $token"});
            // print(user.displayName);
            // print(user.email);
            // print(user.uid);

            print("login success via firebase otp auto");

            // Fluttertoast.showToast(msg: "OTP successfully verified", fontSize: 16, backgroundColor: Color.fromRGBO(1, 185, 255, 1), textColor: Colors.white, toastLength: Toast.LENGTH_LONG);
            success();
          }
          // await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          //   print("Verification Completed Automatically");
          // });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) async {
          final signedCode = await SmsAutoFill().getAppSignature;
          print("Signed Code" + signedCode);
          _listenOtp();
          print("Verification Code Sent");
          appSignature = signedCode;
          _verificationCode = verficationID;

        },
        codeAutoRetrievalTimeout: (String verificationID) {

          _verificationCode = verificationID;

        },
        timeout: Duration(seconds: 120));
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void initState() {
    _verifyPhone();
    createSharedPref();
    _register();
    _loginWithPhoneBloc=LoginWithPhoneBloc();
    _profileUpdateBloc=new ProfileUpdateBloc();


    // button = RaisedButton(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(18.0),
    //     ),
    //     color: lightThemeRed,
    //     onPressed: () {
    //       if (_formKey.currentState.validate()) {
    //         // onSubmit();
    //         otpVerification();
    //       }
    //     },
    //     child: Text(
    //       "Verify",
    //       style: TextStyle(fontSize: 15.0, color: Colors.white),
    //     ));
    // _listenOtp();
  }

  login(){
    Map body={
      // "userid": userId.toString(),
      // "skuid": "${snapshot.data.data[index].skuId}",
      "mobile_number":"+91${widget.mobileNumber.toString()}",
      "deviceid":"${DeviceID.toString()}",
      "cartid":""
    };
    _loginWithPhoneBloc.userLogin(body);
  }

  otpVerification() async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: otpController.text);
      User user = (await _auth.signInWithCredential(credential)).user;

      if (user != null) {
        print("successfully verify manually");
        login();
        var token = await user.getIdToken();
        print("token --- : $token");
        // var response = await httpClient.get(url,headers: {'Authorization':"Bearer $token"});
        print(user.displayName);
        print(user.email);
        print(user.uid);
        success();
      } else {
        print("Error");
      }
    } catch (PlatformException) {
      print("$PlatformException");
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: lightThemeRed,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: lightThemeRed,
            elevation: 0.0,
          ),
          body: ListView(
            children: [

              Container(
                  decoration: new BoxDecoration(
                      color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.only(topLeft: const Radius.circular(15.0), topRight: const Radius.circular(15.0))),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .07,
                          right: MediaQuery.of(context).size.width * .07,
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 80),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Verification Code",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(left: MediaQuery.of(context).size.width * .07, bottom: MediaQuery.of(context).size.height * .05),
                        child: Text(
                          "Please enter verification code sent to your mobile",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .07,
                          right: MediaQuery.of(context).size.width * .07,
                        ),
                        child: PinPut(
                          fieldsCount: 6,
                          focusNode: _pinPutFocusNode,
                          controller: otpController,
                          submittedFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          selectedFieldDecoration: _pinPutDecoration,
                          followingFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.red[800]),
                          ),
                          validator: (value) {
                            if (value.length < 6) {
                              return 'Invalid Otp';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 120),
                        // alignment: Alignment.center,
                        child: Center(
                          child: ButtonTheme(height: 50.0, minWidth: MediaQuery.of(context).size.width * .87,
                            child: StreamBuilder<ApiResponse<LoginWithPhoneModel>>(
                              stream: _loginWithPhoneBloc.userLoginStream,
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
                                      Map body;
                                      File imageFile1;
                                        body={
                                          "name":"$userName",
                                          "email":"$userEmail",
                                          "user_id":"${snapshot.data.data.data.id}"
                                        };
                                        updateCheck=true;
                                        _profileUpdateBloc.profileUpdate(body, imageFile1, snapshot.data.data.success.token);

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
                                          msg: "Please try again!",
                                          fontSize: 16,
                                          backgroundColor: Colors.white,
                                          textColor: lightThemeRed,
                                          toastLength: Toast.LENGTH_LONG);
                                      print("error");
                                      break;
                                  }
                                }
                                return RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  color: lightThemeRed,
                                  onPressed: () {

                                    if (_formKey.currentState.validate()) {
                                      // onSubmit();
                                      otpVerification();
                                    }
                                  },
                                  child: Text(
                                    "Verify",
                                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                                  ));
                              }
                            ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 40,
                        ),
                        // alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive otp code?",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OtpPage(),
                                    ));
                              },
                              child: Text(
                                " Resend OTP",
                                style: TextStyle(color: lightThemeRed, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )),
              Visibility(
                visible: false,
                child: PinFieldAutoFill(
                    onCodeChanged: (val) {
                      print("Changed");
                      otpController.text = val;
                      print("OTP" + val);
                    }, //code changed callback
                    codeLength: 6 //code length, default 6
                ),
              ),
              StreamBuilder<ApiResponse<ProfileUpdateModel>>(
                stream: _profileUpdateBloc.profileUpdateStream,
                builder: (context, snapshot) {
                  if(updateCheck){
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          // return CircularProgressIndicator(
                          //     backgroundColor: circularBGCol,
                          //     strokeWidth: strokeWidth,
                          //     valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)
                          // );
                          /*Loading(
                              loadingMessage: snapshot.data.message,
                            );*/
                          break;
                        case Status.COMPLETED:
                          if (snapshot.data.data.message == "Profile updated successfully")
                          {
                            print("complete");
                            updateCheck=false;
                            // navToAttachList(context);
                            // Fluttertoast.showToast(
                            //     msg: "Profile Updated",
                            //     fontSize: 16,
                            //     backgroundColor: Colors.white,
                            //     textColor: Colors.blue,
                            //     toastLength: Toast.LENGTH_LONG);
                          }else{
                            // Fluttertoast.showToast(
                            //     msg: "${snapshot.data.data.message}",
                            //     fontSize: 16,
                            //     backgroundColor: Colors.white,
                            //     textColor: Colors.blue,
                            //     toastLength: Toast.LENGTH_LONG);
                          }
                          break;
                        case Status.ERROR:
                          print(snapshot.error);
                          updateCheck=false;
                          // Fluttertoast.showToast(
                          //     msg: "Please try again!",
                          //     fontSize: 16,
                          //     backgroundColor: Colors.orange[100],
                          //     textColor: Colors.blue,
                          //     toastLength: Toast.LENGTH_LONG);
                          //   Error(
                          //   errorMessage: snapshot.data.message,
                          // );
                          break;
                      }
                    }
                    else if (snapshot.hasError) {
                      updateCheck=false;
                      print(snapshot.error);
                      Fluttertoast.showToast(
                          msg: "Please try again!",
                          fontSize: 16,
                          backgroundColor: Colors.orange[100],
                          textColor: darkThemeRed,
                          toastLength: Toast.LENGTH_LONG);
                    }
                  }
                  return Container();
                },
              ),

            ],
          )),
    );
  }

  void success() async {
    Future.delayed(Duration.zero, () async {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationButton(//phoneNumber: widget.mobileNumber,
      // )));
      Fluttertoast.showToast(
          msg: "OTP Verified",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: darkThemeRed,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
    });
  }
}
