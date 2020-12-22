import 'package:desichatkara/app_screens/screens/AddressList.dart';
import 'package:desichatkara/app_screens/screens/Cart1.dart';
import 'package:desichatkara/app_screens/screens/Home.dart';
import 'package:desichatkara/app_screens/screens/KitchenDetailedMenu1.dart';
import 'package:desichatkara/app_screens/screens/KitchensNearYou.dart';
import 'package:desichatkara/app_screens/screens/Login.dart';
import 'file:///D:/STUDY/Android_flutter/desichatkara-flutter-main/desichatkara-flutter-main/lib/app_screens/orderDetails_screen/OrderHistory.dart';
import 'package:desichatkara/app_screens/screens/SignUpLogin.dart';
import 'package:desichatkara/app_screens/screens/Starting.dart';
import 'package:desichatkara/app_screens/screens/UserProfile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       // theme: new ThemeData(scaffoldBackgroundColor: Color.fromRGBO(2, 4, 16, 0.0)),
        debugShowCheckedModeBanner: false,
        title: "My flutter app",
        home: Scaffold(
          body:Starting(),
         // backgroundColor: Colors.blue),
         // body:Cart(),
        )

    );
  }
}