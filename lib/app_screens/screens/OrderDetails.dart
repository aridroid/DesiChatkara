import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: lightThemeRed,
            centerTitle: true,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            }),
            title: Text(
              "Order Details",
              style: new TextStyle(
                  color: Colors.white, fontSize: 18.0, fontWeight: font_bold),
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Center(
                  child: Text(
                    "Order #114",
                    style: new TextStyle(
                        color: darkThemeRed,
                        fontSize: 15.0,
                        fontWeight: font_semibold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Center(
                  child: Text(
                    "Order Placed on Friday, November 27,2020",
                    style: new TextStyle(color: darkThemeRed, fontSize: 14.0),
                  ),
                ),
              ),
              Container(
                height: scH * 0.26,
                padding: const EdgeInsets.all(15.0),
                child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.orange,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 12),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Arsalan",
                                      style: TextStyle(
                                          color: darkThemeRed,
                                          fontSize: 18.0,
                                          fontWeight: font_bold),
                                    ),
                                    Text(
                                      "28,Circus Ave, Kolkata,700007",
                                      style: TextStyle(
                                          color: darkThemeRed,
                                          fontSize: 12.0,
                                          fontWeight: font_semibold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 10),
                              child: Icon(
                                Icons.home,
                                color: Colors.orange,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 12, bottom: 10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Home",
                                      style: TextStyle(
                                          color: darkThemeRed,
                                          fontSize: 18.0,
                                          fontWeight: font_bold),
                                    ),
                                    Text(
                                      "28,Circus Ave, Kolkata,700007",
                                      style: TextStyle(
                                          color: darkThemeRed,
                                          fontSize: 12.0,
                                          fontWeight: font_semibold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                //height: scH * 0.3,
                padding: const EdgeInsets.all(15.0),
                child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                ),
                                child: Text(
                                  "Invoice Details",
                                  style: TextStyle(
                                      color: darkThemeRed,
                                      fontSize: 18.0,
                                      fontWeight: font_bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 12, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "User Name",
                                      style: TextStyle(
                                          color: darkThemeRed,
                                          fontSize: 14.0,
                                          fontWeight: font_semibold),
                                    ),
                                    Text(
                                      "user@gmail.com",
                                      style: TextStyle(
                                          color: darkThemeRed,
                                          fontSize: 14.0,
                                          fontWeight: font_semibold),
                                    ),
                                    Text(
                                      "9638527410",
                                      style: TextStyle(
                                          color: darkThemeRed,
                                          fontSize: 14.0,
                                          fontWeight: font_semibold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.builder(
                              itemCount: 2,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        "Full veg biryani",
                                        style: TextStyle(
                                            color: darkThemeRed,
                                            fontSize: 14.0,
                                            fontWeight: font_semibold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "x 3",
                                        style: TextStyle(
                                            color: darkThemeRed,
                                            fontSize: 14.0,
                                            fontWeight: font_semibold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "₹ 160.00",
                                        style: TextStyle(
                                            color: darkThemeRed,
                                            fontSize: 14.0,
                                            fontWeight: font_semibold),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Order Amount",
                                  style: TextStyle(
                                      color: darkThemeRed,
                                      fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Rs. 160.00",
                                  style: TextStyle(
                                      color: darkThemeRed,
                                      fontSize: 14.0,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Tax & GST",
                                  style: TextStyle(
                                    color: darkThemeRed,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "+ Rs. 160.00",
                                  style: TextStyle(
                                    color: darkThemeRed,
                                    fontSize: 14.0,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Delivery Charge",
                                  style: TextStyle(
                                    color: darkThemeRed,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "+ Rs. 60.00",
                                  style: TextStyle(
                                    color: darkThemeRed,
                                    fontSize: 14.0,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10,bottom: 15),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14.0,fontWeight: font_bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Rs. 160.00",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 14.0,fontWeight: font_bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
