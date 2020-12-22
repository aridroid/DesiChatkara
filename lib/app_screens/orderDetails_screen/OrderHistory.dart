import 'package:desichatkara/app_screens/orderDetails_screen/model/orderDetailsModel.dart';
import 'package:desichatkara/app_screens/orderDetails_screen/repository/orderDetailsRepository.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Order History",
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
            },
          ),
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
                                  Container(
                                    margin: EdgeInsets.only(right: 8.0, top: 8.0),
                                    height: 45.0,
                                    width: 45.0,

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
                                  Container(
                                    width: 150.0,
                                    margin: EdgeInsets.only(left: 12.0, top: 12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Gopal Kitchen",
                                          style: new TextStyle(color: Colors.black, fontSize: 14.0),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                          child: Text(
                                            "Delivered",
                                            style: new TextStyle(color: Colors.green, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20.0),
                                    width: 60.0,
                                    child: Text(
                                      "160.00",
                                      style: new TextStyle(color: Colors.black, fontSize: 16.0),
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
                                        Expanded(
                                          child: Text(
                                            "Breakfast.00",
                                            style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                                          ),
                                        ),
                                        Text(
                                          "11 Nov, 2020",
                                          style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "4 x Chola Bhatora",
                                              style: new TextStyle(color: Colors.black, fontSize: 16.0),
                                            ),
                                          ),
                                          Text(
                                            "Reorder",
                                            style: new TextStyle(color: Colors.red[900], fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    )
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
