import 'package:desichatkara/app_screens/profile_screen/profileManage.dart';
import 'package:desichatkara/app_screens/screens/Starting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  SharedPreferences prefs;
  String name="";
  String email="";
  String userPhoto="";


  void initState() {
    super.initState();
    createSharedPref();
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString("user_token")==""){
      Fluttertoast.showToast(
          msg: "Please Login First",
          fontSize: 16,
          backgroundColor: Colors.white,
          textColor: lightThemeRed,
          toastLength: Toast.LENGTH_LONG);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return Starting();
          }));
    }
    name=prefs.getString("name");
    email=prefs.getString("email");
    userPhoto=prefs.getString("user_photo");
    print(prefs.getString("name"));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightThemeRed,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left:30.0),
          child: Text(
            "Profile",
            style: new TextStyle(color: Colors.white, fontSize: 17.0),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_on_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
          // IconButton(
          //   icon: Icon(Icons.shopping_cart_outlined),
          //   color: Colors.white,
          //   onPressed: () {},
          // ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: screenWidth,
            height: 180,
            color: lightThemeRed,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  clipBehavior: Clip.hardEdge,
                   child: FadeInImage(
                    image: NetworkImage(
                      // imageBaseURL + snapshot.data.data[index].couponBannerUrl,
                      "$imageBaseURL$userPhoto",
                    ),
                    width: 110.0,
                    height: 110.0,
                    placeholder: AssetImage('images/profile.png',),
                    fit: BoxFit.fill,
                  ),


                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                  child: Text(
                    "$name",
                    style: new TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
                Text(
                  "$email",
                  style: new TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.person_outline,
                color: Colors.red,
              ),
              title: const Text("Manage Profile"),
              onTap: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileManagePage(),
                            ));
                //ProfileManagePage
              }),
          ListTile(
              leading: const Icon(
                Icons.notifications_on_outlined,
                color: Colors.red,
              ),
              title: const Text("Notifications"),
              onTap: () {
                /* react to the tile being tapped */
              }),
          ListTile(
              leading: const Icon(
                Icons.payment_outlined,
                color: Colors.red,
              ),
              title: const Text("Payment"),
              onTap: () {
                /* react to the tile being tapped */
              }),
          ListTile(
              leading: const Icon(
                Icons.lock_outline,
                color: Colors.red,
              ),
              title: const Text("Change Password"),
              onTap: () {
                /* react to the tile being tapped */
              }),
          ListTile(
              leading: const Icon(
                Icons.login_outlined,
                color: Colors.red,
              ),
              title: const Text("Logout"),
              onTap: () {
                print(prefs.getString("cart_id"));
                print(prefs.getKeys());
                prefs.setString("cart_id", "");
                prefs.setString("coupon_code", "");
                prefs.setString("user_id", "");
                prefs.setString("token", "");
                prefs.setString("name", "");
                prefs.setString("email", "");
                prefs.setString("user_token", "");
                prefs.setString("cart_item_number", "");
                prefs.setBool("user_login", false);
                userLogin=false;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Starting();
                    }));
                /* react to the tile being tapped */
              }),
        ],
      ),
    );
  }
}

class UserProfileAppBar extends StatefulWidget with PreferredSizeWidget {
  //GlobalKey<ScaffoldState> gkey;

  @override
  final Size preferredSize;
  final String title;
  final String name;
  final String email;

  UserProfileAppBar(
      this.name,this.email,
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(230.0),
        super(key: key);

  @override
  _UserProfileAppBarState createState() => _UserProfileAppBarState(name,email);
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {

  final String name;
  final String email;

  _UserProfileAppBarState(this.name, this.email);
  //GlobalKey<ScaffoldState> gkey;
  //_CartAppBarState({this.gkey});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(143, 23, 35, 1),
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text(
              "Profile",
              style: new TextStyle(color: Colors.white, fontSize: 17.0),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_on_outlined),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                color: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'images/profile.png',
              width: 110.0,
              height: 110.0,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text(
              "$name",
              style: new TextStyle(color: Colors.white, fontSize: 17.0),
            ),
          ),
          Text(
            "$email",
            style: new TextStyle(color: Colors.white, fontSize: 17.0),
          ),
        ],
      ),
    );
  }
}
