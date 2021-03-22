import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:desichatkara/app_screens/Home/model/ActiveCuponModel.dart';
import 'package:desichatkara/app_screens/Home/repository/ActiveCuponRepo.dart';
import 'package:desichatkara/app_screens/screens/NavigationButton.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ApplyCoupon/CouponApplyBlock.dart';
import 'ApplyCoupon/CouponApplyModel.dart';

class PromoCodePage extends StatefulWidget {
  @override
  _PromoCodePageState createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  TextEditingController _couponController = new TextEditingController();

  SharedPreferences prefs;
  String userId;
  String userToken;
  String vendorId;
  String parentCategoryId;
  String cartAmount;
  String appliedCouponCode = "";

  CouponApplyBloc _couponApplyBloc;
  Future<ActiveCuponResponseModel> activeCupon;
  ActiveCuponRepository _activeCuponRepository;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id");
    userToken = prefs.getString("user_token");
    vendorId = prefs.getString("vendor_id");
    parentCategoryId = prefs.getString("parent_category_id");
    cartAmount = prefs.getString("Total_cart_amount");
    _activeCuponRepository = ActiveCuponRepository();
    activeCupon = _activeCuponRepository.getactiveCupon();
    // appliedCouponCode=prefs.getString("coupon_code");
    // _couponController.text=appliedCouponCode;
    // Map _body = {"userid": "$userId"};
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
    _couponApplyBloc = new CouponApplyBloc();
    //_allCouponApi=_foodHomeRepo.allCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: lightThemeWhite,
      appBar: AppBar(
          backgroundColor: darkThemeRed,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Center(
              child: Text(
            "Promo Code Offers",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045),
          )),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ]),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          StreamBuilder<ApiResponse<CouponApplyModel>>(
            stream: _couponApplyBloc.couponApplyStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Container();
                    break;
                  case Status.COMPLETED:
                    {
                      if (snapshot.data.data.data != null) {
                        prefs.setString("coupon_code", appliedCouponCode);
                        print("........--... applied");
                        Fluttertoast.showToast(
                            msg: "Coupon Applied",
                            fontSize: 16,
                            backgroundColor: Colors.orange[100],
                            textColor: darkThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return NavigationButton(
                              currentIndex: 2,
                            );
                          }));
                        });
                      } else {
                        Navigator.pop(context);
                        print("........--... Not apply");
                        Fluttertoast.showToast(
                            msg: "Coupon is not valid for cart items",
                            fontSize: 16,
                            backgroundColor: Colors.orange[100],
                            textColor: darkThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                        Future.delayed(Duration.zero, () {});
                      }
                    }
                    break;
                  case Status.ERROR:
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Please try again",
                        fontSize: 16,
                        backgroundColor: Colors.orange[100],
                        textColor: darkThemeRed,
                        toastLength: Toast.LENGTH_LONG);
                    break;
                }
              } else if (snapshot.hasError) {
                print("error");
              }
              return Container();
            },
          ),
          Container(
            height: 45.0,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(15, 25, 15, 10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    enableSuggestions: true,
                    controller: _couponController,
                    style: TextStyle(fontSize: 14.0),
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.local_offer_outlined,
                          color: Colors.grey[400],
                        ),
                        hintText: "Enter Promo Code Here",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ButtonTheme(
                    //  /_To Enlarge Button Size_/
                    height: 45.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_couponController.text.trim() == "") {
                          Fluttertoast.showToast(
                              msg: "Please Enter Coupon Code",
                              fontSize: 16,
                              backgroundColor: Colors.orange[100],
                              textColor: darkThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                        } else {
                          Map body;
                          body = {
                            "coupon_code": "${_couponController.text.trim()}",
                            "vendor_id": "$vendorId",
                            "category_id": "$parentCategoryId",
                            "cart_total_amount": "$cartAmount",
                            "user_id": "$userId"
                          };
                          appliedCouponCode = _couponController.text.trim();
                          _couponApplyBloc.couponApply(body, userToken);
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return WillPopScope(
                                  onWillPop: () async => false,
                                  child: Dialog(
                                    backgroundColor: Colors.white60,
                                    clipBehavior: Clip.hardEdge,
                                    insetPadding: EdgeInsets.all(0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: SizedBox(
                                        width: 30.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                            backgroundColor: circularBGCol,
                                            strokeWidth: strokeWidth,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    circularStrokeCol)),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                      color: darkThemeRed,
                      textColor: Colors.white,
                      child: Text("Apply",
                          style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<ActiveCuponResponseModel>(
            future: activeCupon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data.isNotEmpty) {
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.03,
                        screenWidth * 0.01, screenWidth * 0.03, 20),
                    shrinkWrap: true,
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: darkThemeRed,
                        elevation: 2,
                        //shape: CouponShapeBorder(),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                darkThemeRed,
                                Color.fromRGBO(240, 33, 10, 1)
                              ])),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth * 0.03,
                                      screenWidth * 0.03,
                                      screenWidth * 0.00,
                                      screenWidth * 0.03),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            snapshot
                                                .data.data[index].couponCode,
                                            style: GoogleFonts.poppins(
                                                fontSize: screenWidth * 0.045,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Spacer(),
                                          InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        // title: Text("Give the code?"),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: InkWell(
                                                                    child: Icon(
                                                                      Icons
                                                                          .cancel,
                                                                      color:
                                                                          darkThemeRed,
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    }),
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        top:
                                                                            12.0,
                                                                      ),
                                                                      clipBehavior:
                                                                          Clip.hardEdge,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(2))),
                                                                      child:
                                                                          FadeInImage(
                                                                        height:
                                                                            110.0,
                                                                        width:
                                                                            90.0,
                                                                        image:
                                                                            NetworkImage(
                                                                          "$imageBaseURL${snapshot.data.data[index].couponBannerUrl}",
                                                                        ),
                                                                        placeholder:
                                                                            AssetImage("images/veg_meal.png"),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 4,
                                                                    child:
                                                                        Column(
                                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 10.0,
                                                                              left: 8),
                                                                          child:
                                                                              Text(
                                                                            "${snapshot.data.data[index].couponDescription}",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 15.0,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 8.0,
                                                                              left: 10),
                                                                          child:
                                                                              Text(
                                                                            "Valid From : ${snapshot.data.data[index].couponValidFrom}",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 12.0,
                                                                              // fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 5.0,
                                                                              left: 1),
                                                                          child:
                                                                              Text(
                                                                            "Valid To : ${snapshot.data.data[index].couponValidTo}",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 12.0,
                                                                              // fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 10.0,
                                                                              left: 10),
                                                                          child:
                                                                              Row(
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
                                                                                  (snapshot.data.data[index].vendors.length > 0) ? "${snapshot.data.data[index].vendors[0].shopName}" : "For All Vendors",
                                                                                  style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 10.0,
                                                                              left: 10),
                                                                          child:
                                                                              Row(
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
                                                                                "${snapshot.data.data[index].couponCode}",
                                                                                style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              Center(
                                                                child:
                                                                    new FlatButton(
                                                                        shape: RoundedRectangleBorder(
                                                                            side: BorderSide(
                                                                                color: Colors.deepOrange,
                                                                                width: 1,
                                                                                style: BorderStyle.solid),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        child: const Text(
                                                                          "Copy Coupon Code",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.deepOrangeAccent,
                                                                            fontSize:
                                                                                14.0,
                                                                            // fontWeight: FontWeight.bold
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          ClipboardManager.copyToClipBoard("${snapshot.data.data[index].couponCode}")
                                                                              .then((result) {
                                                                            Fluttertoast.showToast(
                                                                                msg: "${snapshot.data.data[index].couponCode} Copied to Your ClipBoard",
                                                                                fontSize: 14,
                                                                                //webBgColor: Colors.red,

                                                                                backgroundColor: Colors.white,
                                                                                textColor: darkThemeRed,
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
                                              child: Text(
                                                "DETAILS    ",
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        screenWidth * 0.03,
                                                    color: Colors.orange[100],
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Expires",
                                        style: GoogleFonts.poppins(
                                            fontSize: screenWidth * 0.03,
                                            color: Colors.white70),
                                      ),
                                      Text(
                                        "${snapshot.data.data[index].couponValidTo}",
                                        style: GoogleFonts.poppins(
                                            fontSize: screenWidth * 0.035,
                                            color: Color.fromRGBO(
                                                232, 234, 236, 1.0),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot
                                            .data.data[index].couponDescription,
                                        style: GoogleFonts.poppins(
                                            fontSize: screenWidth * 0.037,
                                            color: Colors.orange[200],
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    Map body;
                                    body = {
                                      "coupon_code":
                                          "${snapshot.data.data[index].couponCode}",
                                      "vendor_id": "$vendorId",
                                      "category_id": "$parentCategoryId",
                                      "cart_total_amount": "$cartAmount",
                                      "user_id": "$userId"
                                    };
                                    appliedCouponCode =
                                        snapshot.data.data[index].couponCode;
                                    _couponApplyBloc.couponApply(
                                        body, userToken);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return WillPopScope(
                                            onWillPop: () async => false,
                                            child: Dialog(
                                              backgroundColor: Colors.white60,
                                              clipBehavior: Clip.hardEdge,
                                              insetPadding: EdgeInsets.all(0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child: CircularProgressIndicator(
                                                      backgroundColor:
                                                          circularBGCol,
                                                      strokeWidth: strokeWidth,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              circularStrokeCol)),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth * 0.00),
                                    child: Text(
                                      "Apply Now",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     icon: Icon(
                      //       Icons.add,
                      //       color: Colors.white,
                      //     )),

                      Icon(
                        Icons.home_work_outlined,
                        color: Colors.black87,
                        size: screenWidth * 0.2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'WE DON\'T HAVE ANY COUPON',
                        style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                return Text("No Data Found");
              } else
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ListTileShimmer(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        height: 20,
                        isDisabledAvatar: false,
                        isRectBox: true,
                        colors: [Colors.white],
                      );
                    });
            },
          ),
        ],
      ),
    ));
  }
}
