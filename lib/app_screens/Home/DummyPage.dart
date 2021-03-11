import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:delivery_on_time/cart_screen/cart_page.dart';
import 'package:delivery_on_time/cart_screen/model/cartItemsDetailsModel.dart';
import 'package:delivery_on_time/cart_screen/repository/cartRepository.dart';
import 'package:delivery_on_time/constants.dart';
import 'package:delivery_on_time/restaurants_screen/model/allCouponModel.dart' as acm;
import 'package:delivery_on_time/restaurants_screen/model/recentOrdersModel.dart';
import 'package:delivery_on_time/restaurants_screen/model/restaurantsListModel.dart';
import 'package:delivery_on_time/restaurants_screen/recentOrders.dart';
import 'package:delivery_on_time/restaurants_screen/repository/foodHomeRepository.dart';
import 'package:delivery_on_time/restaurants_screen/shop_details.dart';
import 'package:delivery_on_time/screens/mapCurrentAddressPicker.dart';
import 'package:delivery_on_time/screens/shop_detailsdemo.dart';
import 'package:delivery_on_time/search_screen/searchPage.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'customAppBarFoodHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:math' show cos, sqrt, asin;

class FoodHome extends StatefulWidget {
  // 18001025963
  final int _categodyId;

  FoodHome(this._categodyId);

  @override
  _FoodHomeState createState() => _FoodHomeState(_categodyId);
}

class _FoodHomeState extends State<FoodHome> {
  final int _categodyId;

  _FoodHomeState(this._categodyId);

  String address = "";
  FoodHomeRepository _foodHomeRepo = new FoodHomeRepository();

  List offer_images = ["offer1.png", "offer2.png", "offer1.png", "offer2.png", "offer1.png"];

  List restaurants_images = [
    "pizzaHut.png",
    "dhaba.png",
    "snacksShop.png",
    "biriyaniHouse.png",
  ];

  List restaurants_name = [
    "Pizzahut Kolkata",
    "Raushan Shahi Dhaba",
    "Snacks Shop",
    "Biriyani House",
  ];

  List offerPlaceHolder=[
    "blue.png",
    "yellow.png",
    "green.png",
  ];
  // "red.png",
  List restroPlaceHolder=[
    "food1.png",
    "food2.png",
    "food3.png",
    "food4.png",
  ];
  // "food6.png",
  // "food5.png",

  int restroIndex=0;
  int offerIndex=0;

  List<acm.Data> allCouponData = [];

  SharedPreferences prefs;
  String userId = "";
  String userToken = "";
  String _cartId = "";
  Future<RecentOrdersModel> _recentOrderApi;
  Future<RestaurantsListModel> _restroListApi;
  Future<acm.AllCouponModel> _allCouponApi;
  Map _body;
  CartRepository _cartRepository;
  int cartItemNo = 0;
  DateTime startTime;
  DateTime endTime;
  DateTime nowTime=DateTime.now();
  DateTime availableFrom;
  DateTime availableTo;

  List<double> shopDistance=new List<double>();
  List<bool> shopTimingAvailability=new List<bool>();

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id");
    userToken = prefs.getString("user_token");
    _cartId = prefs.getString("cart_id");
    print("cart $_cartId");
    print("cart ${prefs.getString("cart_id")}");
    Map _body = {"userid": "$userId"};
    _recentOrderApi = _foodHomeRepo.recentOrders(_body, userToken);
    _restroListApi = _foodHomeRepo.restaurantsList(_categodyId);
    _allCouponApi = _foodHomeRepo.allCouponList();
    // cartItemNo=prefs.getString("cart_item_number");
    _body = {"cartid": _cartId, "userid": userId};
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _cartRepository = new CartRepository();
    // _getLocation();
    createSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //Custom AppBar....
          appBar: CustomAppBarFoodHome(address, _cartId),
          backgroundColor: darkThemeBlue, //Main Body Back Color
          body: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              (userId != "" && _cartId != "")
                  ? FutureBuilder<CartItemsDetailsModel>(
                future: _cartRepository.cartItemsDetails(_body),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.data.totalIncludingTaxDelivery != null) {
                      setState(() {
                        cartItemNo = snapshot.data.data.cartItems.length;
                      });
                      return Container();
                    } else
                      return Container();
                  } else if (snapshot.hasError) {
                    return Text("No Data Found");
                  } else
                    return Container();
                },
              )
                  : Container(),



              //Offer Images...

              FutureBuilder<acm.AllCouponModel>(
                future: _allCouponApi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data.data.length; i++) {
                      if (snapshot.data.data[i].categories[0].categoryId == _categodyId.toString()) {
                        allCouponData.add(snapshot.data.data[i]);
                        // print(i);
                      }
                    }
                    if(allCouponData.length>0){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Offer Text...
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 20, 10, 10),
                              child: Text(
                                "OFFERS",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14.0),
                              )),

                          Container(
                            color: darkThemeBlue,
                            height: 195.0,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: allCouponData.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  offerIndex=(index-((index/offerPlaceHolder.length).floor()*offerPlaceHolder.length));
                                  // print(offerIndex);
                                  return InkWell(
                                    onTap: () {
                                      // print("$imageBaseURL${allCouponData[index].couponBannerUrl}");
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) {
                                            return AlertDialog(
                                              // title: Text("Give the code?"),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(),
                                                        ),
                                                        Expanded(
                                                          flex: 6,
                                                          child: Container(
                                                            clipBehavior: Clip.hardEdge,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                                                            child: FadeInImage(
                                                              height: 180.0,
                                                              width: 130.0,
                                                              image: NetworkImage(
                                                                "$imageBaseURL${allCouponData[index].couponBannerUrl}",
                                                              ),
                                                              placeholder: AssetImage("assets/images/placeHolder/Offer/blue.png"),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Align(
                                                            alignment: Alignment.topRight,
                                                            child: InkWell(
                                                                child: Icon(Icons.cancel_outlined),
                                                                onTap: () {
                                                                  Navigator.pop(context);
                                                                }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 10.0),
                                                      child: Text(
                                                        "${allCouponData[index].couponDescription}",
                                                        style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 12.0),
                                                      child: Text(
                                                        "Valid From : ${allCouponData[index].couponValidFrom}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12.0,
                                                          // fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Text(
                                                        "Valid To : ${allCouponData[index].couponValidTo}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12.0,
                                                          // fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 10.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Vendors : ",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 12.0,
                                                              // fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              (allCouponData[index].vendors.length > 0)
                                                                  ? "${allCouponData[index].vendors[0].shopName}"
                                                                  : "For All Vendors",
                                                              style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 10.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Coupon Code : ",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 12.0,
                                                              // fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                          Text(
                                                            "${allCouponData[index].couponCode}",
                                                            style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Colors.red,
                                                    ),
                                                    Center(
                                                      child: new FlatButton(
                                                          shape: RoundedRectangleBorder(
                                                              side: BorderSide(color: Colors.deepOrange, width: 1, style: BorderStyle.solid),
                                                              borderRadius: BorderRadius.circular(5)),
                                                          child: const Text(
                                                            "Copy Coupon Code",
                                                            style: TextStyle(
                                                              color: Colors.deepOrangeAccent,
                                                              fontSize: 14.0,
                                                              // fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            ClipboardManager.copyToClipBoard("${allCouponData[index].couponCode}").then((result) {
                                                              Fluttertoast.showToast(
                                                                  msg: "${allCouponData[index].couponCode} Copied to Your ClipBoard",
                                                                  fontSize: 14,
                                                                  backgroundColor: Colors.orange[100],
                                                                  textColor: darkThemeBlue,
                                                                  toastLength: Toast.LENGTH_LONG);
                                                              Navigator.pop(context);
                                                            });
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                                      margin: EdgeInsets.all(8.0),
                                      color: darkThemeBlue,
                                      child: Container(
                                        // margin: EdgeInsets.only(bottom: 15),
                                        height: 120.0,
                                        width: 120.0,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(color: lightThemeBlue, borderRadius: BorderRadius.all(Radius.circular(12))),
                                        child: FadeInImage(
                                          image: NetworkImage(
                                            "$imageBaseURL${allCouponData[index].couponBannerUrl}",
                                          ),
                                          placeholder: AssetImage("assets/images/placeHolder/Offer/${offerPlaceHolder[offerIndex]}"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    }else
                      return Container();

                  } else if (snapshot.hasError) {
                    return Text("No Data Found");
                  } else
                    return VideoShimmer(
                      padding: EdgeInsets.all(0.0),
                      margin: EdgeInsets.only(top: 15,bottom: 20),
                      hasBottomBox: false,
                    );
                },
              ),

              Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 10, 10),
                  child: Text(
                    "Popular Restaurants".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14.0),
                  )),

              //Popular Restaurants Details
              (userAddress!=null)?
              FutureBuilder<RestaurantsListModel>(
                future: _restroListApi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        // cacheExtent: 10,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {

                          restroIndex=(index-((index/restroPlaceHolder.length).floor()*restroPlaceHolder.length));
                          // print("restroIndex : $restroIndex");

                          double totalDistance = calculateDistance(
                              userLat,
                              userLong,
                              (snapshot.data.data[index].latitude != null)
                                  ? double.parse(snapshot.data.data[index].latitude)
                                  : userLat,
                              (snapshot.data.data[index].longitude != null)
                                  ? double.parse(snapshot.data.data[index].longitude)
                                  : userLong);
                          // double totalDistance = calculateDistance(userLat, userLong, 22.620943, 88.398922);

                          // print("${snapshot.data.data[index].shopName} $totalDistance");
                          shopDistance.add(totalDistance);
                          availableFrom=DateFormat("HH:mm:ss").parse(snapshot.data.data[index].availableFrom);
                          availableTo=DateFormat("HH:mm:ss").parse(snapshot.data.data[index].availableTo);


                          // print(snapshot.data.data[index].shopName);
                          if(DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableFrom.hour,availableFrom.minute))>0 &&
                              DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableTo.hour,availableTo.minute))<0){
                            shopTimingAvailability.add(true);
                            // print("Shop open");
                          }else{
                            shopTimingAvailability.add(false);
                            // print("Shop Closed");
                          }
                          // print(DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableFrom.hour,availableFrom.minute)));
                          // print(DateTime.now().compareTo(DateTime.now()));

                          return InkWell(
                            onTap: () {
                              if (shopDistance[index] <= 10.0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopDetail(
                                          shopLat: (snapshot.data.data[index].latitude != null)
                                              ? double.parse(snapshot.data.data[index].latitude)
                                              : userLat,
                                          shopLong: (snapshot.data.data[index].longitude != null)
                                              ? double.parse(snapshot.data.data[index].longitude)
                                              : userLong,
                                          categoryId: snapshot.data.data[index].categoryId,
                                          vendorId: snapshot.data.data[index].vendorId,
                                          vendorName: snapshot.data.data[index].shopName,
                                          shopAvailability: shopTimingAvailability[index],
                                          // snapshot.data.data[index].categoryId,
                                          // snapshot.data.data[index].vendorId,
                                          // snapshot.data.data[index].shopName
                                        )));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "${snapshot.data.data[index].shopName} is Undeliverable at your location",
                                    fontSize: 14,
                                    backgroundColor: Colors.orange[100],
                                    textColor: darkThemeBlue,
                                    toastLength: Toast.LENGTH_LONG);
                              }
                            },
                            child: Stack(
                              children: [

                                Container(
                                    margin: EdgeInsets.all(7.0),
                                    padding: EdgeInsets.all(5.0),
                                    height: screenWidth * 0.27,
                                    // width: screenWidth*0.05,
                                    // height: 100.0,
                                    // color: Colors.white,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.0)), color: Colors.white),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: screenWidth * 0.24,
                                              // width: screenWidth * 0.20,
                                              // height: double.infinity,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                              ),
                                              child: FadeInImage(
                                                image: NetworkImage("$imageBaseURL${snapshot.data.data[index].vendorImage}"),
                                                placeholder: AssetImage("assets/images/placeHolder/restro/${restroPlaceHolder[restroIndex]}"),
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            // color: Colors.redAccent,
                                            width: screenWidth * 0.58,
                                            margin: EdgeInsets.only(left: 15.0, top: 4.0, right: 10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Text("${snapshot.data.data[index].shopName}",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: screenWidth * 0.04)),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "${snapshot.data.data[index].address}",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: screenWidth * 0.032),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        size: screenWidth * 0.037,
                                                        color: Colors.orangeAccent,
                                                      ),
                                                      Text(
                                                        " ${snapshot.data.data[index].averageRating??4.2}",
                                                        style: TextStyle(
                                                          color: Colors.orangeAccent,
                                                        ),
                                                      ),
                                                      Spacer(),

                                                      // SizedBox(
                                                      //   width: 20.0,
                                                      // ),
                                                      Icon(
                                                        Icons.access_time,
                                                        color: Colors.black45,
                                                        size: screenWidth * 0.032,
                                                      ),
                                                      Text(
                                                        " ${snapshot.data.data[index].availableFrom.split(":")[0]}:${snapshot.data.data[index].availableFrom.split(":")[1]} - ${snapshot.data.data[index].availableTo.split(":")[0]}:${snapshot.data.data[index].availableTo.split(":")[1]}",
                                                        textAlign: TextAlign.end,
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                            color: Colors.black45,
                                                            fontSize: screenWidth * 0.030),
                                                      ),
                                                      // Icon(
                                                      //   Icons.access_time,
                                                      //   size: screenWidth * 0.032,
                                                      //   color: Colors.deepOrange,
                                                      // ),
                                                      // Text("  30m",
                                                      //     style: TextStyle(
                                                      //       fontWeight: FontWeight.bold,
                                                      //       fontSize: screenWidth * 0.030,
                                                      //       color: Colors.deepOrange,
                                                      //     )),
                                                      Spacer(),
                                                      (shopTimingAvailability[index])?
                                                      Text("OPEN",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: screenWidth * 0.032,
                                                            color: Colors.green,
                                                          ))
                                                          :
                                                      Text("CLOSED",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: screenWidth * 0.032,
                                                            color: Colors.red[800],
                                                          ))

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.all(7.0),
                                  padding: EdgeInsets.all(5.0),
                                  height: screenWidth * 0.27,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      color: (shopDistance[index] <= 10.0)?Colors.white10.withOpacity(0):Colors.white10.withOpacity(0.5)),
                                ),
                              ],

                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("No Data Found");
                  } else
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index){
                          return ListTileShimmer(
                            padding: EdgeInsets.only(top: 0,bottom: 0),
                            margin: EdgeInsets.only(top: 20,bottom: 20),
                            height: 20,
                            isDisabledAvatar: false,
                            isRectBox: true,
                            colors: [
                              Colors.white
                            ],
                          );
                        }
                    );
                },
              )
                  :
              Container(
                margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: lightThemeBlue,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline_rounded,
                      color: Colors.white,
                      size: 28,),
                    SizedBox(
                      width: 2,
                    ),
                    Flexible(
                      child: Text("  Please Select Delivery Location",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                  ],
                ),
              ),

              //Your Recent Orders Text...

              //Your Recent Orders List
              RecentOrders(),

              SizedBox(
                height: 50.0,
              )
            ],
          )),
    );
  }

// _getLocation() async {
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   debugPrint('location: ${position.latitude}');
//   final coordinates = new Coordinates(position.latitude, position.longitude);
//   var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   var first = addresses.first;
//   address = "${first.addressLine}";
//   print("${first.featureName} : ${first.addressLine}");
//   setState(() {});
// }

// double calculateDistance(lat1, lon1, lat2, lon2) {
//   var p = 0.017453292519943295;
//   var c = cos;
//   var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//   return 12742 * asin(sqrt(a));
// }
}