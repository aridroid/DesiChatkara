import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:delivery_on_time/cart_screen/cart_page.dart';
import 'package:delivery_on_time/cart_screen/model/cartItemsDetailsModel.dart';
import 'package:delivery_on_time/cart_screen/repository/cartRepository.dart';
import 'package:delivery_on_time/constants.dart';
import 'package:delivery_on_time/restaurants_screen/model/allCouponModel.dart' as acm;
import 'package:delivery_on_time/restaurants_screen/model/recentOrdersModel.dart';
import 'package:delivery_on_time/restaurants_screen/model/restaurantsListModel.dart' as rlm;
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
  Future<rlm.RestaurantsListModel> _restroListApi;
  Future<acm.AllCouponModel> _allCouponApi;
  Map _body;
  CartRepository _cartRepository;
  int cartItemNo = 0;
  DateTime startTime;
  DateTime endTime;
  DateTime nowTime=DateTime.now();
  DateTime availableFrom;
  DateTime availableTo;
  List<rlm.Data> restroList=[];
  List<rlm.Data> availableRestroList=[];

  // List<double> shopDistance=new List<double>();
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
              FutureBuilder<rlm.RestaurantsListModel>(
                future: _restroListApi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    restroList=snapshot.data.data;
                    for(int i=0;i<restroList.length;i++){

                      double totalDistance = calculateDistance(
                          userLat,
                          userLong,
                          (restroList[i].latitude != null)
                              ? double.parse(restroList[i].latitude)
                              : userLat,
                          (restroList[i].longitude != null)
                              ? double.parse(restroList[i].longitude)
                              : userLong);


                      restroList[i].distance=totalDistance;

                      availableFrom=DateFormat("HH:mm:ss").parse(restroList[i].availableFrom);
                      availableTo=DateFormat("HH:mm:ss").parse(restroList[i].availableTo);

                      if(DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableFrom.hour,availableFrom.minute))>0 &&
                          DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableTo.hour,availableTo.minute))<0){
                        shopTimingAvailability.add(true);
                        availableRestroList.add(snapshot.data.data[i]);

                      }else{
                      }

                    }

                    availableRestroList.sort((a,b)=> a.distance.compareTo(b.distance));

                    return ListView.builder(
                        shrinkWrap: true,
                        // cacheExtent: 10,
                        physics: ScrollPhysics(),
                        itemCount: availableRestroList.length,
                        itemBuilder: (context, index) {

                          restroIndex=(index-((index/restroPlaceHolder.length).floor()*restroPlaceHolder.length));
                          // print("restroIndex : $restroIndex");

                          /*double totalDistance = calculateDistance(
                              userLat,
                              userLong,
                              (availableRestroList[index].latitude != null)
                                  ? double.parse(availableRestroList[index].latitude)
                                  : userLat,
                              (availableRestroList[index].longitude != null)
                                  ? double.parse(availableRestroList[index].longitude)
                                  : userLong);
                          // double totalDistance = calculateDistance(userLat, userLong, 22.620943, 88.398922);

                          // print("${availableRestroList[index].shopName} $totalDistance");
                          shopDistance.add(totalDistance);
                          availableFrom=DateFormat("HH:mm:ss").parse(availableRestroList[index].availableFrom);
                          availableTo=DateFormat("HH:mm:ss").parse(availableRestroList[index].availableTo);


                          // print(availableRestroList[index].shopName);
                          if(DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableFrom.hour,availableFrom.minute))>0 &&
                              DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableTo.hour,availableTo.minute))<0){
                            shopTimingAvailability.add(true);
                            // print("Shop open");
                          }else{
                            shopTimingAvailability.add(false);
                            // print("Shop Closed");
                          }*/

                          // print(DateTime.now(). compareTo(DateTime(nowTime.year,nowTime.month,nowTime.day,availableFrom.hour,availableFrom.minute)));
                          // print(DateTime.now().compareTo(DateTime.now()));

                          return Visibility(
                            visible: (availableRestroList[index].distance <= 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopDetail(
                                          shopLat: (availableRestroList[index].latitude != null)
                                              ? double.parse(availableRestroList[index].latitude)
                                              : userLat,
                                          shopLong: (availableRestroList[index].longitude != null)
                                              ? double.parse(availableRestroList[index].longitude)
                                              : userLong,
                                          categoryId: availableRestroList[index].categoryId,
                                          vendorId: availableRestroList[index].vendorId,
                                          vendorName: availableRestroList[index].shopName,
                                          shopAvailability: shopTimingAvailability[index],
                                          // availableRestroList[index].categoryId,
                                          // availableRestroList[index].vendorId,
                                          // availableRestroList[index].shopName
                                        )));
                              },
                              child: Container(
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
                                              image: NetworkImage("$imageBaseURL${availableRestroList[index].vendorImage}"),
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
                                                child: Text("${availableRestroList[index].shopName}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold, color: Colors.black, fontSize: screenWidth * 0.04)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "${availableRestroList[index].address}",
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
                                                      " ${availableRestroList[index].averageRating??4.2}",
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
                                                      " ${availableRestroList[index].availableFrom.split(":")[0]}:${availableRestroList[index].availableFrom.split(":")[1]} - ${availableRestroList[index].availableTo.split(":")[0]}:${availableRestroList[index].availableTo.split(":")[1]}",
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

// Custom AppBar Class...
// class CustomAppBar extends PreferredSize {
//   final String _address;
//   final String _cartId;
//   final int cartItemNo;
//
//   CustomAppBar(this._address, this._cartId, this.cartItemNo);
//
//   @override
//   Size get preferredSize => Size.fromHeight(120.0);
//
//   @override
//   Widget build(BuildContext context) {
//     print("cart hereeaaae $_cartId");
//     return Container(
//       height: 120.0,
//       child: Column(
//         children: [
//           //Upper Container with Address and icons....
//           Container(
//             margin: EdgeInsets.fromLTRB(15, 0, 10, 5),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(0.0, 5.0, 3.0, 5.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Icon(
//                       Icons.location_on,
//                       color: Colors.white,
//                       size: 18.0,
//                     ),
//                   ),
//
//                   //Address Text....
//                   Expanded(
//                     flex: 9,
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => MapHomePage1(
//                                       pageIndex: 1,
//                                     )
//                                 // AddressPage()
//                                 ));
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 2.9),
//                             child: Text(
//                               "Delivery Location",
//                               overflow: TextOverflow.visible,
//                               style: TextStyle(color: Colors.white70, fontSize: 10.5),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 flex: 7,
//                                 child: Text(
//                                   userAddress??"Choose Delivery Address...",
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(color: Colors.white, fontSize: 12.5),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Icon(
//                                   Icons.edit_outlined,
//                                   color: Colors.white,
//                                   size: 15.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//
//                     ),
//                   ),
//
//                   //Address Arrow Icon....
//                   /*Icon(
//                     Icons.keyboard_arrow_down,
//                     color: Colors.white,
//                     size: 14.0,
//                   ),*/
//
//                   //Bell Icon in Expanded....
//                   // Expanded(
//                   //   flex: 1,
//                   //   child: Badge(
//                   //
//                   //     position: BadgePosition.bottomStart(bottom: 10.0,start: 14.0),
//                   //     badgeContent: Text('3',style: TextStyle(
//                   //       fontSize: 12.0,
//                   //       color: Colors.white
//                   //     ),),
//                   //     badgeColor: Colors.deepOrangeAccent,
//                   //     child: Icon(Icons.shopping_cart_outlined,
//                   //       color: Colors.white,
//                   //       size: 24.0,),
//                   //   ),
//                   // ),
//                   /*Expanded(
//                     flex: 1,
//                     child: Container(
//                       alignment: Alignment.centerRight,
//                       child: (_cartId!="")?InkWell(
//                         onTap: (){
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => CartPage()
//                                 // AddressPage()
//                               ));
//                         },
//                         child: Badge(
//                           position: BadgePosition.bottomStart(bottom: 10.0,start: 14.0),
//                           badgeContent: Text('$cartItemNo',style: TextStyle(
//                               fontSize: 12.0,
//                               color: Colors.white
//                           ),),
//                           badgeColor: Colors.deepOrangeAccent,
//                           child: Icon(Icons.shopping_cart_outlined,
//                             color: Colors.white,
//                             size: 24.0,),
//                         ),
//                       ):IconButton(
//                         icon: Icon(
//                           Icons.remove_shopping_cart_outlined,
//                           color: Colors.deepOrangeAccent,
//                           size: 24.0,
//                         ),
//                         onPressed: () {
//                           Fluttertoast.showToast(
//                               msg: "You Have Nothing In Your Cart",
//                               fontSize: 16,
//                               backgroundColor: Colors.orange[100],
//                               textColor: darkThemeBlue,
//                               toastLength: Toast.LENGTH_LONG);
//                           // do something
//                         },
//                       ),
//                     ),
//                   )*/
//
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                         alignment: Alignment.centerRight,
//                         child: /(_cartId!="")?/ IconButton(
//                           icon: Icon(
//                             Icons.shopping_cart_outlined,
//                             color: Colors.white,
//                             size: 22.0,
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => CartPage()
//                                     // AddressPage()
//                                     ));
//                           },
//                         )
//                         /*:IconButton(
//                         icon: Icon(
//                           Icons.remove_shopping_cart_outlined,
//                           color: Colors.white,
//                           size: 22.0,
//                         ),
//                         onPressed: () {
//                           Fluttertoast.showToast(
//                               msg: "You Have Nothing In Your Cart",
//                               fontSize: 16,
//                               backgroundColor: Colors.orange[100],
//                               textColor: darkThemeBlue,
//                               toastLength: Toast.LENGTH_LONG);
//                           // do something
//                         },
//                       ),*/
//                         ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//
//           //Search TextFiled Container....
//           Container(
//             height: 45.0,
//             alignment: Alignment.topCenter,
//             margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//             ),
//             child: TextField(
//               readOnly: true,
//               style: TextStyle(fontSize: 14.0),
//               textAlignVertical: TextAlignVertical.top,
//               decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.search),
//                   hintText: "search",
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14.0,
//                   ),
//                   border: InputBorder.none),
//               onTap: () {
//                 showSearch(context: context, delegate: SearchPage());
//               },
//             ),
//           ),
//         ],
//       ),
//
//       // height: preferredSize.height,
//       // color: lightThemeBlue,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: lightThemeBlue,
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
//       ),
//       // child: child,
//     );
//   }
// }