import 'package:desichatkara/app_screens/screens/Starting.dart';
import 'package:desichatkara/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_screens/screens/NavigationButton.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Set keys = prefs.getKeys();

  if (keys.contains("user_token")) {
    print("user_token exist"+prefs.getString("user_token"));
    if (prefs.getString("user_token") != "")
    {
      // userLogin=prefs.getBool("user_login");
      userLogin=true;
    }
  } else
    prefs.setString("user_token", "");

  if (keys.contains("user_id")) {
    // print("user_id exist"+prefs.getString("user_id"));
  } else
    prefs.setString("user_id", "");

  if (keys.contains("cart_id")) {
    print("cart_id exist"+prefs.getString("cart_id"));
  } else{
    prefs.setString("cart_id", "");
    print("cart id create ${prefs.getString("cart_id")}");
  }


  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: true,
      theme: ThemeData(
        fontFamily: 'HelveticaNeue'
      ),
      home: (userLogin==true)?NavigationButton():Starting()
  ));
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