import 'package:desichatkara/app_screens/CartPage/bloc/cartItemsUpdateBloc.dart';
import 'package:desichatkara/app_screens/CartPage/model/cartItemsDetailsModel.dart';
import 'package:desichatkara/app_screens/CartPage/model/cartItemsUpdateModel.dart';
import 'package:desichatkara/app_screens/CartPage/repository/cartRepository.dart';
import 'package:desichatkara/app_screens/address_screens/addressListPage.dart';
import 'package:desichatkara/app_screens/screens/Login.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:desichatkara/utility/Error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List _productAmount = new List();
  CartRepository _cartRepository;
  CartItemsUpdateBloc _cartItemsUpdateBloc;
  SharedPreferences prefs;
  Map _body;
  Future<CartItemsDetailsModel> _cartApi;

  bool cartChangeCheck = false;
  String _userToken = "";
  // ignore: non_constant_identifier_names
  String cart_id = "";
  // ignore: non_constant_identifier_names
  String user_id = "";
  // ignore: non_constant_identifier_names
  String coupon_code = "";

  @override
  void initState() {
    super.initState();
    _cartRepository = new CartRepository();
    _cartItemsUpdateBloc = CartItemsUpdateBloc();
    createSharedPref();
    // if(prefs.getString("cart_id")!="")
    // print("cartId at Cart page"+prefs.getString("cart_id"));
  }

  Future<void> managedSharedPref(CartItemsDetailsModel data) async {
    prefs.setString("Total_cart_amount", data.data.totalIncludingTaxDelivery);
    // cartId=data.data.cartItems[0].cartId;
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    print("cartId at Cart page1" + prefs.getString("cart_id"));
    cart_id = prefs.getString("cart_id");
    user_id = prefs.getString("user_id");
    _userToken = prefs.getString("user_token");
    coupon_code = prefs.getString("coupon_code");

    if (coupon_code == null) coupon_code = "";

    _body = {"cartid": cart_id, "userid": user_id, "coupon_code": coupon_code};
    print("data cart");
    print(_body);
    _cartApi = _cartRepository.cartItemsDetails(_body);
    setState(() {});
  }

  // if(prefs.getString("cart_id")!="")
  // {
// };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 23, 35, 1),
        automaticallyImplyLeading: false,
        title: Text(
          "Cart",
          style: new TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_on_outlined),
            color: Colors.white,
            onPressed: () {},
          ),

          /* IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                color: Colors.white,
                onPressed: () {},
              ),*/
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            StreamBuilder<ApiResponse<CartItemsUpdateModel>>(
              stream: _cartItemsUpdateBloc.cartItemsUpdateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Container();
                      break;
                    case Status.COMPLETED:
                      {
                        print("data update +++in cart page");
                        if (cartChangeCheck) {
                          Future.delayed(Duration.zero, () {
                            setState(() {
                              _cartApi = _cartRepository.cartItemsDetails(_body);
                              cartChangeCheck = false;
                            });
                          });
                        }
                      }
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                      );
                      break;
                  }
                } else if (snapshot.hasError) {
                  print("error");
                }

                return Container();
              },
            ),
            FutureBuilder<CartItemsDetailsModel>(
              future: _cartApi,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data.totalIncludingTaxDelivery != null) {
                    managedSharedPref(snapshot.data);
                    return ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                        ListView.builder(
                            itemCount: int.parse(snapshot.data.data.cartItemCount),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              _productAmount.add(int.parse(snapshot.data.data.cartItems[index].quantity));
                              return Container(
                                margin: EdgeInsets.all(6.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.0)), color: Colors.white),
                                // height: screenHeight * .14,
                                child: Row(children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: screenWidth * 0.2,
                                      // width: screenWidth * 0.20,
                                      // height: double.infinity,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                        color: Colors.white
                                      ),
                                      child: FadeInImage(
                                        image: NetworkImage(
                                          "$imageBaseURL${snapshot.data.data.cartItems[index].detailedProductImages}",
                                        ),
                                        placeholder: AssetImage("images/logo.jpeg"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      // color: Colors.red,
                                      // padding: EdgeInsets.only(
                                      //     left: screenWidth * .03,
                                      //     top: screenHeight * .020,
                                      //     bottom: screenHeight * .016),
                                      margin: EdgeInsets.only(left: 15.0, top: 0.0, bottom: 0.0, right: 10.0),
                                      // color: Colors.blue,
                                      height: screenHeight * .1,
                                      // width: screenWidth * .68,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${snapshot.data.data.cartItems[index].skuName}",
                                              style: TextStyle(fontSize: screenWidth * .04, fontWeight: FontWeight.bold, fontFamily: 'pop'),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "RS. ${snapshot.data.data.cartItems[index].totalprice}",
                                                  style: TextStyle(
                                                      fontSize: screenWidth * .036,
                                                      fontWeight: FontWeight.bold,
                                                      color: lightThemeRed,
                                                      fontFamily: 'pop'),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    int _quantity = _productAmount[index] - 1;

                                                    Map body = {
                                                      "cart_item_id": "${snapshot.data.data.cartItems[index].cartItemId}",
                                                      "quantity": "$_quantity"
                                                    };
                                                    _cartItemsUpdateBloc.cartItemsUpdate(body);
                                                    setState(() {
                                                      _productAmount[index]--;
                                                      cartChangeCheck = true;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.remove_circle_outline,
                                                    color: lightThemeRed,
                                                    size: screenWidth * .07,
                                                  ),
                                                ),
                                                SizedBox(width: screenWidth * .007),
                                                Center(
                                                    child: Text(
                                                  "${_productAmount[index]}",
                                                  style: TextStyle(fontSize: screenWidth * .04, fontFamily: 'pop'),
                                                )),
                                                SizedBox(width: screenWidth * .007),
                                                InkWell(
                                                  onTap: () {
                                                    int _quantity = _productAmount[index] + 1;

                                                    Map body = {
                                                      "cart_item_id": "${snapshot.data.data.cartItems[index].cartItemId}",
                                                      "quantity": "$_quantity"
                                                    };
                                                    _cartItemsUpdateBloc.cartItemsUpdate(body);
                                                    setState(() {
                                                      _productAmount[index]++;
                                                      cartChangeCheck = true;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.add_circle_outline,
                                                    color: lightThemeRed,
                                                    size: screenWidth * .07,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            }),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * .02, right: 5, left: 5),
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * .03),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12.0)), color: Colors.white),
                            width: screenWidth * .94,
                            // height: screenHeight * .25,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Total Amount",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Rs.${snapshot.data.data.cartTotalAmount}",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                                (snapshot.data.data.totalAfterDiscount != null)
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Discount Amount",
                                              style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
                                            ),
                                            Spacer(),
                                            Text(
                                              "[ - ] Rs.${double.parse(snapshot.data.data.cartTotalAmount) - double.parse(snapshot.data.data.totalAfterDiscount)}",
                                              style:
                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04, color: Colors.green),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                                (snapshot.data.data.totalAfterDiscount != null)
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Amount After Discount",
                                              style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Rs.${snapshot.data.data.totalAfterDiscount}",
                                              style:
                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04, color: Colors.black),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Total Tax",
                                        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Rs.${snapshot.data.data.taxAmount}",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04, color: lightThemeRed),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Delivery charges",
                                        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Rs.${snapshot.data.data.deliveryFee}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04, color: Colors.orangeAccent),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Total Amount Including Charges",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "RS.${snapshot.data.data.totalIncludingTaxDelivery}",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * .02, right: 5, left: 5),
                          child: InkWell(
                            onTap: () {
                              if (_userToken == "") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                                Fluttertoast.showToast(
                                    msg: "Please Login First",
                                    fontSize: 16,
                                    backgroundColor: Colors.white,
                                    textColor: darkThemeRed,
                                    toastLength: Toast.LENGTH_LONG);
                              } else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddressListPage(
                                  latitude: snapshot.data.data.cartItems[0].latitude,
                                  longitude: snapshot.data.data.cartItems[0].longitude,
                                )));
                              }
                            },
                            child: Container(
                              //color: Colors.red[900],
                              // width: MediaQuery.of(context).size.width*.90,
                              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 5.0),
                              decoration: BoxDecoration(
                                //color:Colors.red[900],
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                color: Colors.red[900],
                              ),

                              // color: Colors.white,
                              height: 50.0,
                              // padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Center(child: Text("Proceed", style: new TextStyle(color: Colors.white, fontSize: 16.0))),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * .1)
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 10, 30),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "".toUpperCase(),
                              // textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14.0),
                            )),
                        Image.asset(
                          "images/cart.png",
                          height: 150.0,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            "Your Cart is Empty",
                            style: TextStyle(color: lightThemeRed, fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        )
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text("No Data Found");
                } else
                  return Center(
                    heightFactor: 5,
                    widthFactor: 10,
                    child: CircularProgressIndicator(
                        backgroundColor: circularBGCol,
                        strokeWidth: strokeWidth,
                        valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)),
                  );
              },
            ),

            //Spacer(),
          ],
        ),
      ),
    );
  }
}

class CartAppBar extends StatefulWidget with PreferredSizeWidget {
  //GlobalKey<ScaffoldState> gkey;

  @override
  final Size preferredSize;

  final String title;

  CartAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(120.0),
        super(key: key);

  @override
  _CartAppBarState createState() => _CartAppBarState();
}

class _CartAppBarState extends State<CartAppBar> {
  //GlobalKey<ScaffoldState> gkey;
  //_CartAppBarState({this.gkey});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
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
              "Cart",
              style: new TextStyle(color: Colors.white, fontSize: 17.0),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_on_outlined),
                color: Colors.white,
                onPressed: () {},
              ),

              /* IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                color: Colors.white,
                onPressed: () {},
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
