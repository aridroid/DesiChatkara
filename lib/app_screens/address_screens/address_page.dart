import 'package:desichatkara/app_screens/address_screens/repository/addressRepository.dart';
import 'package:desichatkara/app_screens/orderDetails_screen/OrderHistory.dart';
import 'package:desichatkara/app_screens/orderPlace_paymennt/RazorPayScreen.dart';
import 'package:desichatkara/app_screens/orderPlace_paymennt/bloc/orderPlaceBloc.dart';
import 'package:desichatkara/app_screens/orderPlace_paymennt/model/OrderPlaceResponseModel.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/addressByAddressIdModel.dart';

class AddressPage extends StatefulWidget {
  final String addressId;

  AddressPage({this.addressId});

  @override
  _AddressPageState createState() => _AddressPageState(addressId);
}

class _AddressPageState extends State<AddressPage> {

  final String addressId;

  _AddressPageState(this.addressId);

  String _paymentMode;
  bool _orderplaced=false;

  Future<AddressByAddressIdModel> _addressFetchApi;

  AddressRepository _addressRepository;
  Map _response;
  OrderPlaceBloc _orderPlaceBloc;

  String _name;
  String cartId;
  String userId;
  String userToken;
  String userPhone="";
  String totalCartAmount;
  String coupon_code;
  Map body;
  SharedPreferences prefs;

  Future<void> createSharedPref() async {
   prefs = await SharedPreferences.getInstance();
   print(prefs.getString("name"));
   _name=prefs.getString("name");
   userToken = prefs.getString("user_token");
   userPhone = prefs.getString("user_phone");
   cartId = prefs.getString("cart_id");
   print(cartId);
   userId = prefs.getString("user_id");
   totalCartAmount = prefs.getString("Total_cart_amount");
   coupon_code = prefs.getString("coupon_code");
   body = {"addressid": "$addressId"};
   _addressFetchApi = _addressRepository.addressByAddressId(body, userToken);
   setState(() {
   });
  }



  @override
  void initState() {
    super.initState();
    _addressRepository = new AddressRepository();
    createSharedPref();
    _orderPlaceBloc=OrderPlaceBloc();
    // _getLocation();
  }
  navToAttachList(context,OrderPlaceResponseModel data) async {
    Future.delayed(Duration.zero, () {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return RazorPayScreen(snapshotData: data,userToken: userToken,totalCartAmount: totalCartAmount,);
      }));
      _orderplaced=false;
    });
  }

  String address="";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: lightThemeRed,
          /*onPressed: () {
          },*/
          label: Container(
            padding: EdgeInsets.fromLTRB(10,5,10,5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: lightThemeRed),
            width: screenWidth * .80,
            height: 40,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        " Total Amount",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Rs.$totalCartAmount",
                        style: TextStyle(
                            color: Colors.white, fontSize: 12,
                            fontWeight: FontWeight.bold),

                      ),
                    )
                  ],
                ),
                Spacer(),
                StreamBuilder<ApiResponse<OrderPlaceResponseModel>>(
                  stream: _orderPlaceBloc.orderPlaceStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return CircularProgressIndicator(
                              backgroundColor: circularBGCol,
                              strokeWidth: strokeWidth,
                              valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)
                          );

                          break;
                        case Status.COMPLETED:
                        // if (snapshot.data.data.success != null)
                          {
                            print("complete");
                            if(snapshot.data.data.data.paymentType=="cod" && snapshot.data.data.message=="Success" && _orderplaced){
                              Future.delayed(Duration.zero, () {
                                prefs.setString("cart_id","");
                                prefs.setString("cart_item_number","");
                                prefs.setString("coupon_code","");
                                /*Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                  return OrderDetailsPage();
                                }));*/
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => OrderHistory()),ModalRoute.withName("/ShopDetail"));
                              });
                              _orderplaced=false;
                              Fluttertoast.showToast(
                                  msg: "Order has been Placed Successfully",
                                  fontSize: 14,
                                  backgroundColor: Colors.white,
                                  textColor: darkThemeRed,
                                  toastLength: Toast.LENGTH_LONG);
                            }else if(snapshot.data.data.data.paymentType=="online" && _orderplaced){
                              // managedSharedPref(snapshot.data.data);
                              navToAttachList(context,snapshot.data.data);
                              Fluttertoast.showToast(
                                  msg: "You are Redirecting to Payment Gateway",
                                  fontSize: 14,
                                  backgroundColor: Colors.white,
                                  textColor: darkThemeRed,
                                  toastLength: Toast.LENGTH_LONG);
                            }
                          }
                          break;
                        case Status.ERROR:
                          Fluttertoast.showToast(
                              msg: "${snapshot.data.message}",
                              fontSize: 16,
                              backgroundColor: Colors.white,
                              textColor: darkThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                          //   Error(
                          //   errorMessage: snapshot.data.message,
                          // );
                          break;
                      }
                    } else if (snapshot.hasError) {
                      print("error");
                    }

                    return InkWell(
                      onTap: (){
                        if(_paymentMode!=null){
                          _orderplaced=true;
                          Map _body={
                            "userid":"$userId",
                            "cartid":"$cartId",
                            "addressid":"$addressId",
                            "payment_type":"$_paymentMode",
                            "coupon_code": coupon_code
                          };
                          _orderPlaceBloc.orderPlace(_body, userToken);
                        }else{
                          Fluttertoast.showToast(
                              msg: "Please Select Payment Mode",
                              fontSize: 16,
                              backgroundColor: Colors.white,
                              textColor: darkThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                        }


                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Text(
                              " Checkout",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0,left: 3),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),


              ],
            ),
          ),
        ),
        backgroundColor: lightThemeWhite,

        //App Bar...
        appBar: AppBar(
            backgroundColor: lightThemeRed,
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
            title: Center(
                child: Text(
              "Select Payment Mode".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth*0.04
              ),
            )),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ]),
        body: ListView(
          shrinkWrap: true,
          children: [
            //Map Container...
            // Container(
            //   height: screenHeight * 0.30,
            //   child: Image.asset(
            //     "assets/images/map.png",
            //     fit: BoxFit.fill,
            //   ),
            // ),
            // SizedBox(
            //   height: screenHeight * 0.02,
            // ),

            //Main body Margined Container...
            Container(
              margin: EdgeInsets.all(screenHeight * 0.015),
              child: FutureBuilder<AddressByAddressIdModel>(
                future: _addressFetchApi,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        //Add Address Text...
                        Text(" Add Address",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightThemeRed,
                              fontSize: screenWidth * 0.04,
                            )),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),

                        // Address, Name, Phone and others Container...
                        Container(
                          height: screenHeight * 0.19,
                          padding: EdgeInsets.fromLTRB(
                              screenHeight * 0.025,
                              screenHeight * 0.015,
                              screenHeight * 0.015,
                              screenHeight * 0.020),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //First Row...
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    //Name Text...
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          "$_name".toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth * 0.04,
                                          ),
                                        )),

                                    //Right Icon...
                                    Expanded(
                                      flex: 1,
                                      child: Icon(Icons.done,
                                          color: lightThemeRed,
                                          size: screenWidth * 0.05),
                                    )
                                  ],
                                ),
                              ),

                              //Second Row...
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${snapshot.data.data[0].address}, ${snapshot.data.data[0].landmark}, ${snapshot.data.data[0].city}, ${snapshot.data.data[0].state}, ${snapshot.data.data[0].zip}",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.037,
                                      color: Colors.black38),
                                ),
                              ),
                              //Third Row...
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [

                                    // Phone Number and Icon...
                                    Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: [
                                            Icon(Icons.phone_iphone,
                                                color: lightThemeRed,
                                                size: screenWidth * 0.05),
                                            Text(
                                              "$userPhone",
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  color: Colors.black38),
                                            ),
                                          ],
                                        )),

                                    // Edit and Icon...
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit,
                                                color: lightThemeRed,
                                                size: screenWidth * 0.05),
                                            Text(
                                              " Edit",
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),

                                    //Delete and Icon...
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.delete_outline,
                                                color: lightThemeRed,
                                                size: screenWidth * 0.05),
                                            Text(
                                              " Delete",
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.037,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03,),

                        //Add Shippng Address Row Text and Icon...
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Icon(
                        //       Icons.add_circle_outline,
                        //       color: Colors.deepOrange,
                        //       size: screenWidth * 0.045,
                        //     ),
                        //     Text(
                        //       " Add Shipping Address",
                        //       style: TextStyle(
                        //           fontSize: screenWidth * 0.037,
                        //           color: Colors.deepOrange),
                        //     ),
                        //   ],
                        // ),

                        SizedBox(height: screenHeight * 0.04,),

                        Text(" Select Payment Mode",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: lightThemeRed,
                              fontSize: screenWidth * 0.04,
                            )),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),

                        // COD and Online Payment Radio Button..

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                          ),
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                          // margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                          height: 100.0,
                          width: screenWidth,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // height: 20.0,
                                  width: screenWidth,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Radio(
                                          value: "cod",
                                          groupValue: _paymentMode,
                                          onChanged: (value) {
                                            setState(() {
                                              _paymentMode = value;
                                              print(_paymentMode);
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 0.0),
                                          child: Text(
                                            "Cash On Delivery",
                                            style: TextStyle(
                                                color: Colors.lightBlue[900],
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // height: 20.0,
                                  width: screenWidth,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Radio(
                                          value: "online",
                                          groupValue: _paymentMode,
                                          onChanged: (value) {
                                            setState(() {
                                              _paymentMode = value;
                                              print(_paymentMode);
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 0.0),
                                          child: Text(
                                            "Online Payment",
                                            style: TextStyle(
                                                color: Colors.lightBlue[900],
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Home and Office Button Container
                        /*Row(
                          children: [

                            // Home Container...
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  screenHeight * 0.020,
                                  screenHeight * 0.010,
                                  screenHeight * 0.020,
                                  screenHeight * 0.010),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                                  color: orangeCol),
                              child: Text(
                                "Home",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05,),

                            // Office Container...
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  screenHeight * 0.020,
                                  screenHeight * 0.010,
                                  screenHeight * 0.020,
                                  screenHeight * 0.010),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                border: Border.all(color: lightTextBlue),
                              ),
                              child: Text(
                                "Office",
                                style: TextStyle(
                                  color: lightTextBlue,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                          ],
                        ),*/

                        //Total Amount Price Container
                        /*Padding(
                          padding: EdgeInsets.only(top: screenWidth * .09),
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * .025),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: orangeCol),
                            width: screenWidth * .94,
                            height: screenHeight * .10,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        " Total Amount",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.04
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Rs.$totalCartAmount",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: screenWidth * 0.05,
                                            fontWeight: FontWeight.bold),

                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                StreamBuilder<ApiResponse<OrderPlaceResponseModel>>(
                                  stream: _orderPlaceBloc.orderPlaceStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      switch (snapshot.data.status) {
                                        case Status.LOADING:
                                          return CircularProgressIndicator(
                                              backgroundColor: Colors.blue[700],
                                              strokeWidth: 7,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[200])
                                          );

                                          break;
                                        case Status.COMPLETED:
                                          // if (snapshot.data.data.success != null)
                                          {
                                            print("complete");
                                            // managedSharedPref(snapshot.data.data);
                                            navToAttachList(context,snapshot.data.data);
                                            Fluttertoast.showToast(
                                                msg: "${snapshot.data.data.data.name} You are Redirecting to Payment Gateway",
                                                fontSize: 14,
                                                backgroundColor: Colors.white,
                                                textColor: darkThemeBlue,
                                                toastLength: Toast.LENGTH_LONG);
                                          }
                                          break;
                                        case Status.ERROR:
                                          Fluttertoast.showToast(
                                              msg: "${snapshot.data.message}",
                                              fontSize: 16,
                                              backgroundColor: Colors.orange[100],
                                              textColor: darkThemeBlue,
                                              toastLength: Toast.LENGTH_LONG);
                                          //   Error(
                                          //   errorMessage: snapshot.data.message,
                                          // );
                                          break;
                                      }
                                    } else if (snapshot.hasError) {
                                      print("error");
                                    }

                                    return InkWell(
                                      onTap: (){
                                        Map _body={
                                          "userid":"$userId",
                                          "cartid":"$cartId",
                                          "addressid":"$addressId"
                                        };
                                        _orderPlaceBloc.orderPlace(_body, userToken);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              " Checkout",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),


                              ],
                            ),
                          ),
                        ),*/
                        SizedBox(height: screenHeight * .2)
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("No Data Found");
                  } else
                    return Center(
                      heightFactor: 5,
                      widthFactor: 10,
                      child: CircularProgressIndicator(
                        backgroundColor: circularBGCol,
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)
                      ),
                    );
                },

              ),
            )
          ],
        ),
      ),
    );

  }

  _getLocation() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    address="${first.featureName} : ${first.addressLine}";
    print("${first.featureName} : ${first.addressLine}");
    setState(() {

    });
  }
}
