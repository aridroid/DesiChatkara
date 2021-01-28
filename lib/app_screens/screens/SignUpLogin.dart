import 'package:desichatkara/app_screens/UserLogin/sign_in_google.dart';
import 'package:desichatkara/app_screens/screens/Home.dart';
import 'package:desichatkara/app_screens/screens/Login.dart';
import 'package:desichatkara/app_screens/screens/NavigationButton.dart';
import 'package:desichatkara/app_screens/screens/Otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SignUpLogin extends StatefulWidget {
  @override
  _SignUpLoginState createState() => _SignUpLoginState();
}

class _SignUpLoginState extends State<SignUpLogin> {
  bool isLoggedIn = false;
  Sign_in_google sg = new Sign_in_google();

  // PageController scontroller=new PageController();
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
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => NavigationButton(),
            //         ));
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .05, left: MediaQuery.of(context).size.width * .85),
            //     child: Text(
            //       "Skip",
            //       style: new TextStyle(color: Colors.white, fontSize: 14.0),
            //     ),
            //   ),
            // ),
            Center(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .10),
                  child: Text(
                    "SWAD KA CHATKARA SEHAT K SATH",
                    style: new TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
              child: Container(
                height: 200.0,
                child: PageIndicatorContainer(
                  pageView: new PageView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: 4,
                    onPageChanged: (int page) {
                      //getChangedPageAndMoveBar(page);
                    },
                    controller: new PageController(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200.0,
                        //margin: EdgeInsets.only(left:10.0,right:10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4.0),
                          image: DecorationImage(
                            image: AssetImage("images/veg_meal.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        //child: Image.asset("images/poke1.jpg")
                      );
                    },
                  ),
                  length: 4,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpPage(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "images/user.png",
                        height: 22.0,
                        width: 22.0,
                      ),
                      Expanded(child: Center(child: Text("SignUp", style: new TextStyle(color: Colors.black, fontSize: 14.0)))),
                      Container(margin: EdgeInsets.only(left: 30.0), child: Icon(Icons.arrow_forward))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
              ),

              // color: Colors.white,
              height: 50.0,
              // padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "images/user.png",
                        height: 22.0,
                        width: 22.0,
                      ),
                      Expanded(child: Center(child: Text("Login", style: new TextStyle(color: Colors.black, fontSize: 14.0)))),
                      Container(margin: EdgeInsets.only(left: 30.0), child: Icon(Icons.arrow_forward))
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                sg.signInWithGoogle().then((result) {
                  if (result != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return NavigationButton();
                        },
                      ),
                    );
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                ),

                // color: Colors.white,
                height: 50.0,
                // padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "images/google.png",
                        height: 22.0,
                        width: 22.0,
                      ),
                      Expanded(child: Center(child: Text("Login with Google", style: new TextStyle(color: Colors.black, fontSize: 14.0)))),
                      Container(margin: EdgeInsets.only(left: 30.0), child: Icon(Icons.arrow_forward))
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                initiateFacebookLogin();
              },
              child: Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                ),

                // color: Colors.white,
                height: 50.0,
                // padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "images/facebook.png",
                        height: 22.0,
                        width: 22.0,
                      ),
                      Expanded(
                          child: Center(child: Text("Login with Facebook", style: new TextStyle(color: Colors.black, fontSize: 14.0)))),
                      Container(margin: EdgeInsets.only(left: 30.0), child: Icon(Icons.arrow_forward))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 35.0),
              child: Column(
                children: [
                  Text("By continueing past this page, you agree to our", style: new TextStyle(color: Colors.grey, fontSize: 10.0)),
                  Text("Terms of service , Cookie policy , Privacy policy , and Content Policies",
                      style: new TextStyle(color: Colors.grey, fontSize: 10.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        onLoginStatusChanged(true);
        break;
    }
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }
}
