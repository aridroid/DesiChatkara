import 'package:desichatkara/app_screens/orderDetails_screen/model/orderDetailsModel.dart';
import 'package:desichatkara/app_screens/orderDetails_screen/repository/orderDetailsRepository.dart';
import 'package:desichatkara/app_screens/screens/OrderDetails.dart';
import 'package:desichatkara/app_screens/tracking_screen/mapTrackingPage.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CartPage/Cart.dart';
import '../screens/Cart1.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  SharedPreferences prefs;
  String userToken = "";
  String userId = "";
  OrderDetailsRepository _orderDetailsRepository;
  Future<OrderDetailsModel> _orderDetailsApi;
  Map _body;
  var statusCol;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString("user_token");
    userId = prefs.getString("user_id");
    _body = {"userid": "$userId"};
    _orderDetailsRepository = new OrderDetailsRepository();
    _orderDetailsApi = _orderDetailsRepository.orderDetails(_body, userToken);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 23, 35, 1),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Order History",
          style: new TextStyle(color: Colors.white, fontSize: 17.0,fontWeight: font_semibold),
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
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<OrderDetailsModel>(
            future: _orderDetailsApi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (snapshot.data.data[index].transactionStatus == "Failed") {
                        statusCol = Colors.red;
                      } else {
                        statusCol = Colors.green;
                      }
                      return Container(
                        // margin: EdgeInsets.only(left:3.0,right:3.0),
                        child: Card(
                          margin: EdgeInsets.only(top: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2.0,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8.0, top: 8.0,left: screenWidth*.05),
                                      height: screenWidth*.13,
                                      // width: screenWidth*.13,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                        image: DecorationImage(
                                          image: AssetImage("images/pizza.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      //child: Image.asset("images/poke1.jpg")
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      // width: 150.0,
                                      padding: EdgeInsets.only(left: 12.0, top: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ORDER ID : ${snapshot.data.data[index].id}",
                                            style: new TextStyle(color: Colors.black, fontSize: 14.0),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                            child: Text(
                                              "${snapshot.data.data[index].transactionStatus}",
                                              style: new TextStyle(color: statusCol, fontSize: 14.0,fontWeight: font_bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      // width: 60.0,
                                      child: Text(
                                        "Rs.${snapshot.data.data[index].transactionAmount}/-",
                                        style: new TextStyle(color: Colors.black, fontSize: 14.0,fontWeight: font_bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Expanded(
                                        //   // child: Text(
                                        //   //   "Breakfast",
                                        //   //   style: new TextStyle(color: Colors.grey, fontSize: 14.0,fontWeight: font_semibold),
                                        //   // ),
                                        // ),
                                        Spacer(),
                                        Text(
                                          "${DateFormat.yMMMMEEEEd().format(DateFormat("yyyy-MM-dd").parse(snapshot.data.data[index].createdAt, true))}",
                                          style: new TextStyle(color: Colors.grey, fontSize: 14.0,fontWeight: font_semibold),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${snapshot.data.data[index].deliveryAddress}",
                                              style: new TextStyle(color: Colors.black, fontSize: 12.0),
                                            ),
                                          ),
                                          // Text(
                                          //   "Reorder",
                                          //   style: new TextStyle(color: Colors.red[900], fontSize: 16.0,fontWeight: font_bold),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => OrderDetails(orderid: snapshot.data.data[index].orderId,),
                                                ));
                                            //OrderDetails
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * .28,
                                            margin: EdgeInsets.only(left: 5.0, right: 0.0, top: 13.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              color: lightThemeRed,
                                            ),

                                            // color: Colors.white,
                                            height: 50.0,
                                            // padding: EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Center(child: Text("Order Details", style: new TextStyle(color: Colors.white, fontSize: 16.0,fontWeight: font_bold))),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MapTrackingPage(orderData: snapshot.data.data[index]),
                                                ));
                                            //OrderDetails
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * .29,
                                            margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 13.0,),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                              color: lightThemeRed,
                                            ),

                                            // color: Colors.white,
                                            height: 50.0,
                                            // padding: EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Center(child: Text("Order Tracking", style: new TextStyle(color: Colors.white, fontSize: 16.0,fontWeight: font_bold))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("No Data Found");
              } else {
                return Center(
                  heightFactor: 5,
                  widthFactor: 10,
                  child: CircularProgressIndicator(
                      backgroundColor: circularBGCol,
                      strokeWidth: strokeWidth,
                      valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)),
                );
              }
            }),
      ),
    );
  }
}
