import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget{
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: UserProfileAppBar(""),
      body: ListView(
        children: [
         ListTile(
  leading: const Icon(Icons.person_outline,color: Colors.red,),
  title: const Text("Manage Profile"),
  onTap: () { /* react to the tile being tapped */ }
),

ListTile(
  leading: const Icon(Icons.notifications_on_outlined,color: Colors.red,),
  title: const Text("Notifications"),
  onTap: () { /* react to the tile being tapped */ }
),

ListTile(
  leading: const Icon(Icons.payment_outlined,color: Colors.red,),
  title: const Text("Payment"),
  onTap: () { /* react to the tile being tapped */ }
),

ListTile(
  leading: const Icon(Icons.lock_outline,color: Colors.red,),
  title: const Text("Change Password"),
  onTap: () { /* react to the tile being tapped */ }
),

ListTile(
  leading: const Icon(Icons.login_outlined,color: Colors.red,),
  title: const Text("Logout"),
  onTap: () { /* react to the tile being tapped */ }
),
      ],),
    );
  }
}


class UserProfileAppBar extends StatefulWidget with PreferredSizeWidget{
     //GlobalKey<ScaffoldState> gkey;
      
      @override
    final Size preferredSize;

    final String title;

    UserProfileAppBar(
        this.title,
        { Key key,}) : preferredSize = Size.fromHeight(230.0),
            super(key: key);

  @override
  _UserProfileAppBarState createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
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
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
            title: Text("Profile", style: new TextStyle(color: Colors.white,
                     fontSize: 17.0),),
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
       padding: const EdgeInsets.only(top:8.0,bottom:3.0),
       child: Text("John Dongler", style: new TextStyle(color: Colors.white,
                       fontSize: 17.0),),
     ),


      Text("Delhi", style: new TextStyle(color: Colors.white,
                     fontSize: 17.0),),

         ],
        ),

     );
   
  }
}
