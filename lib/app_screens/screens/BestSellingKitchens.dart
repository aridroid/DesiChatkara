//import 'dart:html';

import 'package:desichatkara/app_screens/CartPage/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BestSellingKitchens extends StatefulWidget{
  @override
  _BestSellingKitchens createState() => _BestSellingKitchens();
}

class _BestSellingKitchens extends State<BestSellingKitchens> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 23, 35, 1),
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back,color: Colors.white,))),
        title: Text("Best Selling Kitchens", style: new TextStyle(color: Colors.white,
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
            onPressed: () {
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Cart()));
            },
          ),

        ],
      ),
     
        body: ListView(
          physics:NeverScrollableScrollPhysics(),
          children: [
                Container(
            color: Color.fromRGBO(130, 2, 14, 1),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*.09,
            child: Container(
              margin: EdgeInsets.only(left:12.0,right:12.0),
              child: Row(children: [
                 Icon(Icons.location_on,color: Color.fromRGBO(223, 148, 20, 1),),
                 Expanded(child: Text("KRISHNA NAGAR DELHI-II", style: new TextStyle(color: Colors.white,
                 fontSize: 14.0),)),
                 Text("change", style: new TextStyle(color: Colors.white),)
              ],),
            ),
          ),



            Container(
              height: MediaQuery.of(context).size.height*.80,
              child: Padding(
       padding: const EdgeInsets.all(12.0),
       child: GridView.builder(
                itemCount: 9,  
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                                  crossAxisCount: 2,  
                                  crossAxisSpacing: 3.0,  
                                  mainAxisSpacing: 3.0  
                              ), 

                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  
                // width: 140.0,
                 // height: 180.0,
                 // margin: EdgeInsets.only(left:3.0,right:3.0),
                 child: Card(
                   shape: RoundedRectangleBorder(  
                            borderRadius: BorderRadius.circular(10.0), ), 
                            elevation: 2.0,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                     Container(
                       height: 80.0,
                  
  decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),),
                            image: DecorationImage(
                              
                              image: AssetImage("images/veg_meal.png"),
                              fit: BoxFit.cover,
                            ),
                    ),
  //child: Image.asset("images/poke1.jpg")
  ),

  Container(
              margin: EdgeInsets.only(left:5.0,right:5.0,top:5.0,bottom:3.0),
              child: Row(children: [

                             Expanded(child: Text("Gopal Kitchen", style: new TextStyle(color: Colors.black),)),
                                Icon(Icons.star,color:Colors.green,size:15.0),
                                 Text("4.2", style: new TextStyle(color: Colors.green),)
                                
                           ],
                        ),
  ),

                      Container(
                         margin: EdgeInsets.only(left:5.0,right:5.0,top:3.0,bottom:3.0),
                        child: Text("veg, Lunch", style: new TextStyle(color: Colors.grey),)),
                      Container(
                         margin: EdgeInsets.only(left:5.0,right:5.0),
                        child: Text("brakefast, dinner", style: new TextStyle(color: Colors.grey),))


                   ],),
                 ),
               ); 
                              }




       ),
     ),
            ),
          ],
        ),
   );
  }
}