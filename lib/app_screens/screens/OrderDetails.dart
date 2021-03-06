import 'package:desichatkara/app_screens/OrderDetails/OrderDetailsModel.dart';
import 'package:desichatkara/app_screens/OrderDetails/OrderDetailsRepo.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  final String orderid;

  const OrderDetails({Key key, this.orderid}) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  Future<OrderDetailsModel> _allOrderApi;
  OrderDetailsRepositry _orderDetailsRepository;

  @override
  void initState() {
    super.initState();
    _orderDetailsRepository = new OrderDetailsRepositry();
    createSharedPref();
  }

  SharedPreferences prefs;
  String userToken = "";

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString("user_token");
    //vendorId = prefs.getString("vendorId");
    Map body = {"orderid": widget.orderid.toString()};
    _allOrderApi = _orderDetailsRepository.getOrderDetails(body, userToken);
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final scH = MediaQuery.of(context).size.height;
    final scW = MediaQuery.of(context).size.width;
    return Scaffold(
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
        body: FutureBuilder<OrderDetailsModel>(
            future: _allOrderApi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data != null) {
                  return  ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            "ORDER ID : ${snapshot.data.data.orderDetails[0].orderId}",
                            style: new TextStyle(
                                color: darkThemeRed,
                                fontSize: 15.0,
                                fontWeight: font_semibold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0,right: 10,left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Text(
                            //   "Transaction Status ${snapshot.data.data.orderDetails[0].transactionStatus}",
                            //   style: new TextStyle(color: Colors.black, fontSize: 14.0),
                            // ),
                            // Spacer(),
                            Text(
                              "${DateFormat.yMMMMEEEEd().format(DateFormat("yyyy-MM-dd").parse(snapshot.data.data.orderDetails[0].createdAt, true))}",
                              style: new TextStyle(color: darkThemeRed, fontSize: 14.0),
                            ),

                          ],
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
                                            snapshot.data.data.vendor.shopName,
                                              style: TextStyle(
                                                  color: darkThemeRed,
                                                  fontSize: 18.0,
                                                  fontWeight: font_bold),
                                            ),
                                            Text(
                                              snapshot.data.data.vendor.address,
                                              style: TextStyle(
                                                  color: Colors.black,
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
                                                  snapshot.data.data.orderDetails[0].deliveryAddress,
                                              style: TextStyle(
                                                  color: Colors.black,
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
                                              snapshot.data.data.customer.customerName,
                                              style: TextStyle(
                                                  color:Colors.black,
                                                  fontSize: 14.0,
                                                  fontWeight: font_semibold),
                                            ),
                                            Text(
                                              snapshot.data.data.customer.customerMobile,
                                              style: TextStyle(
                                                  color:Colors.black,
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
                                      itemCount:snapshot.data.data.orderItems.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                snapshot.data.data.orderItems[index].productName,
                                                style: TextStyle(
                                                    color: darkThemeRed,
                                                    fontSize: 14.0,
                                                    fontWeight: font_semibold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "x ${snapshot.data.data.orderItems[index].quantity}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight: font_semibold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "₹ ${snapshot.data.data.orderItems[index].unitPrice}",
                                                style: TextStyle(
                                                    color: Colors.black,
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
                                          "Rs. ${snapshot.data.data.orderDetails[0].orderAmount}",
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
                                  const EdgeInsets.only(left: 10.0, right: 0),
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
                                          " + ${snapshot.data.data.orderDetails[0].taxAmount}",
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
                                  const EdgeInsets.only(left: 10.0, right: 0),
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
                                          " + ${snapshot.data.data.orderDetails[0].deliveryAmount}",
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
                                          "Rs. ${snapshot.data.data.orderDetails[0].transactionAmount}",
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
                  );
                } else {
                  return Center(
                    child: Text(
                      "No Data.",
                      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(
                    "No Data.",
                    style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                );
              } else
                return Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                        backgroundColor: circularBGCol,
                        strokeWidth: strokeWidth,
                        valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)),
                  ),
                );
            }
        ),

    );
  }
}
