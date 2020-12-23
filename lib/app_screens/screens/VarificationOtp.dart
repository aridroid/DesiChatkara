import 'package:desichatkara/app_screens/registrationScreen/SignUp.dart';
import 'package:desichatkara/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationPage extends StatefulWidget {
  String mobileNumber;

  VerificationPage({this.mobileNumber}) {
    print("Mobile Number:" + mobileNumber);
  }

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final otpController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;
  String _verificationCode;
  RaisedButton button;
  String appSignature;

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
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            print("Verification Completed Automatically");
            success();
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) async {
          final signedCode = await SmsAutoFill().getAppSignature;
          print("Signed Code" + signedCode);
          _listenOtp();
          print("Verification Code Sent");
          setState(() {
            appSignature = signedCode;
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void initState() {
    _verifyPhone();
    button = RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: lightThemeRed,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            onSubmit();
          }
        },
        child: Text(
          "Verify",
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ));
    // _listenOtp();
  }

  void onSubmit() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: otpController.text))
          .then((value) async {
        if (value.user != null) {
          success();
        }
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('invalid OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: lightThemeRed,
        appBar: AppBar(
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
                        child: ButtonTheme(height: 50.0, minWidth: MediaQuery.of(context).size.width * .87, child: button),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
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
                            Text(
                              " Resend OTP",
                              style: TextStyle(color: lightThemeRed, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )),
            Visibility(
              visible: true,
              child: PinFieldAutoFill(
                  onCodeChanged: (val) {
                    print("Changed");
                    otpController.text = val;
                    print("OTP" + val);
                  }, //code changed callback
                  codeLength: 6 //code length, default 6
                  ),
            ),
          ],
        ));
  }

  void success() async {
    Future.delayed(Duration.zero, () async {
      Fluttertoast.showToast(
          msg: "OTP Verified",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          timeInSecForIosWeb: 1);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp(phoneNumber: widget.mobileNumber,)));
    });
  }
}
