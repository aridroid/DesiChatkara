import 'package:desichatkara/app_screens/CartPage/bloc/cartEmptyBloc.dart';
import 'package:desichatkara/app_screens/CartPage/bloc/cartItemsAddBloc.dart';
import 'package:desichatkara/app_screens/CartPage/bloc/cartItemsUpdateBloc.dart';
import 'package:desichatkara/app_screens/CartPage/model/cartItemsAddModel.dart';
import 'package:desichatkara/app_screens/CartPage/model/cartItemsUpdateModel.dart';
import 'package:desichatkara/app_screens/KitchenDetails/Repository/foodHomeRepository.dart';
import 'package:desichatkara/app_screens/KitchenDetails/model/foodDetailsModel.dart' as fdm;
import 'file:///D:/STUDY/Android_flutter/desichatkara-flutter-main/desichatkara-flutter-main/lib/app_screens/CartPage/Cart.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:desichatkara/utility/Error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'Cart1.dart';

class KitchenDetailedMenu extends StatefulWidget {
  final String vendorId;
  final String categoryId;
  final String vendorName;

  const KitchenDetailedMenu({Key key, this.vendorId, this.categoryId, this.vendorName}) : super(key: key);

  @override
  _KitchenDetailedMenuState createState() => _KitchenDetailedMenuState(vendorId, categoryId, vendorName);
}

class _KitchenDetailedMenuState extends State<KitchenDetailedMenu> {
  final String vendorId;
  final String categoryId;
  final String vendorName;

  _KitchenDetailedMenuState(this.vendorId, this.categoryId, this.vendorName);

  FoodHomeRepository _foodHomeRepository = new FoodHomeRepository();
  Future<fdm.FoodDetailsModel> _foodDetailsFuture;
  List<List<fdm.ProductDetails>> _productDetailsList = new List<List<fdm.ProductDetails>>();
  List<List<List<int>>> _productAmount = [];
  List<List<List<String>>> _cartItemId = new List();
  List _addVisibility = new List();
  List _moreLessVisibility = new List();
  List _circularProgressVisibility = new List();

  CartItemsAddBloc _cartItemsAddBloc;
  CartItemsUpdateBloc _cartItemsUpdateBloc;
  CartEmptyBloc _cartEmptyBloc;
  SharedPreferences prefs;
  int _index1 = 0;
  int _index = 0;
  int _index0 = 0;

  String currentVendorId;
  String currentCategoryId;

  int productsNumber = 0;
  bool check = true;
  bool setStateCheck = false;

  String _userToken = "";
  String _cartId = "";
  fdm.Data foodDetailsModelData;

  @override
  void initState() {
    super.initState();
    createSharedPref();
    _cartItemsAddBloc = CartItemsAddBloc();
    _cartItemsUpdateBloc = CartItemsUpdateBloc();
    _cartEmptyBloc = CartEmptyBloc();
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    _cartId = prefs.getString("cart_id");
    _userToken = prefs.getString("user_token");
    _foodDetailsFuture = _foodHomeRepository.foodDetails(categoryId, vendorId, _cartId);
    currentVendorId = prefs.getString("vendor_id");
    currentCategoryId = prefs.getString("parent_category_id");
    setState(() {});
  }

  // prefs.reload();
  Future<void> managedSharedPref(CartItemsAddModel data) async {
    prefs.setString("cart_id", data.data.cartItems[0].cartId);
    // cartId=data.data.cartItems[0].cartId;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .30,

                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0),),
                    image: DecorationImage(
                      image: AssetImage("images/veg_meal.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //child: Image.asset("images/poke1.jpg")
                ),
                Container(
                  color: Color.fromRGBO(0, 0, 0, .5),
                  height: MediaQuery.of(context).size.height * .30,
                ),
                AppBar(
                  leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white)),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
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
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${vendorName.toUpperCase()}",
                          style: new TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(2.0),
                          color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 10.0),
                              Text(
                                "4.2",
                                style: new TextStyle(color: Colors.white, fontSize: 10.0),
                              ),
                            ],
                          ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      "veg, lunch, breakfast, dinner",
                      style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ),
                  Text(
                    "216 street, Raayal road kolkata 54",
                    style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              )),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.call, color: Colors.red[900]),
                  Text(
                    "Call",
                    style: new TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                  Text(
                    "for catering",
                    style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.star, color: Colors.red[900]),
                  Text(
                    "Review",
                    style: new TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                  Text(
                    "564",
                    style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.delivery_dining, color: Colors.red[900]),
                  Text(
                    "Delivery",
                    style: new TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                  Text(
                    "9am-9pm",
                    style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.favorite, color: Colors.red[900]),
                  Text(
                    "Favorite",
                    style: new TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ],
              )
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Menu",
                    style: new TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                ),
                Icon(Icons.menu, color: Colors.grey),
              ],
            ),
          ),
          Divider(),
          StreamBuilder<ApiResponse<CartItemsAddModel>>(
            stream: _cartItemsAddBloc.cartItemsAddStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    // alertDialogue(context);
                    break;
                  case Status.COMPLETED:
                    {
                      prefs.setString("cart_id", "${snapshot.data.data.data.cartItems[0].cartId}");
                      print("cart id ${snapshot.data.data.data.cartItems[0].cartId}");
                      _cartItemId[_index0][_index1][_index] = snapshot.data.data.data.cartItemId;
                      print("complete111");
                      print(_cartItemId[_index0][_index1][_index]);
                      print("$_index1 $_index");
                      print(_cartItemId);
                      print(snapshot.data.data.data.cartItemId);
                      managedSharedPref(snapshot.data.data);
                      if (setStateCheck) {
                        Future.delayed(Duration.zero, () {
                          setState(() {
                            _moreLessVisibility[_index0][_index1][_index] = !_moreLessVisibility[_index0][_index1][_index];

                            _circularProgressVisibility[_index0][_index1][_index] = !_circularProgressVisibility[_index0][_index1][_index];
                          });
                        });
                        setStateCheck = false;
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
                      print("data update +++");
                      // prefs.setString("cart_id", "${snapshot.data.data.data.cartItems[0].cartId}");
                      // cartId=snapshot.data.data.data.cartItems[0].cartId;
                      // print(snapshot.data.data.data.cartItems[0].cartId);
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<fdm.FoodDetailsModel>(
              future: _foodDetailsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.data.menu.isNotEmpty) {
                    foodDetailsModelData = snapshot.data.data;
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: foodDetailsModelData.menu[0].subcategory.length,
                      itemBuilder: (context, index0) {
                        if (check) {
                          _productDetailsList.add(new List<fdm.ProductDetails>());
                          _productAmount.add(new List<List<int>>());
                          _cartItemId.add(new List<List<String>>());
                          _addVisibility.add(new List<List<bool>>());
                          _moreLessVisibility.add(new List<List<bool>>());
                          _circularProgressVisibility.add(new List<List<bool>>());
                          for (int i = 0; i < foodDetailsModelData.productDetails.length; i++) {
                            if (foodDetailsModelData.productDetails[i].categoryId == foodDetailsModelData.menu[0].subcategory[index0].id) {
                              if (foodDetailsModelData.productDetails[i].skus.length > 0) {
                                _productDetailsList[index0].add(foodDetailsModelData.productDetails[i]);

                                // Dynamically List Data Generate...
                                // productsNumber = foodDetailsModelData.productDetails[i].skus.length;

                                if (foodDetailsModelData.productDetails[i].skus[0].cartItem == null) {
                                  print("null as6e cart e");
                                } else {
                                  print("ei tate cart count a6e");
                                }
                                _productAmount[index0].add(List.generate(
                                    foodDetailsModelData.productDetails[i].skus.length,
                                    (index) => (foodDetailsModelData.productDetails[i].skus[index].cartItem == null)
                                        ? 0
                                        : int.parse(foodDetailsModelData.productDetails[i].skus[index].cartItem.quantity)));

                                print("_productAmount");
                                _cartItemId[index0].add(List.generate(
                                    foodDetailsModelData.productDetails[i].skus.length,
                                    (index) => (foodDetailsModelData.productDetails[i].skus[index].cartItem == null)
                                        ? "0"
                                        : foodDetailsModelData.productDetails[i].skus[index].cartItem.cartItemId.toString()));

                                print("_cartItemId");

                                _addVisibility[index0].add(List.generate(foodDetailsModelData.productDetails[i].skus.length,
                                    (index) => (foodDetailsModelData.productDetails[i].skus[index].cartItem == null) ? true : false));

                                print("_addVisibility");

                                _moreLessVisibility[index0].add(List.generate(foodDetailsModelData.productDetails[i].skus.length,
                                    (index) => (foodDetailsModelData.productDetails[i].skus[index].cartItem == null) ? false : true));

                                print("_moreLessVisibility");

                                _circularProgressVisibility[index0]
                                    .add(List.generate(foodDetailsModelData.productDetails[i].skus.length, (index) => false));
                              }
                            }
                          }
                          if (foodDetailsModelData.menu[0].subcategory.length-1 == index0) {
                            check = false;
                            print("same hye ge6e");
                          }
                        }
                        print(_productDetailsList[0][0].id);
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15,8,8,8),
                              color: Colors.red[900],
                              width: screenWidth,
                              child: Text("${foodDetailsModelData.menu[0].subcategory[index0].subcategoryname}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                            ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _productDetailsList[index0].length,
                                itemBuilder: (context, index1) {
                                  return StickyHeader(
                                    header: Container(
                                      // height: 30.0,
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0), bottomRight: Radius.circular(5.0)),
                                      ),
                                      child: Text(
                                        _productDetailsList[index0][index1].name.toUpperCase(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.black),
                                      ),
                                    ),
                                    content: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: _productDetailsList[index0][index1].skus.length,
                                        itemBuilder: (context, index) {
                                          // count++;
                                          return Card(
                                            elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              margin: EdgeInsets.only(top: 4.0, bottom: 14.0),
                                              // height: screenWidth * 0.22,
                                              // width: screenWidth*0.05,
                                              // height: 100.0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: screenWidth * 0.2,
                                                        // width: screenWidth * 0.20,
                                                        // height: double.infinity,
                                                        clipBehavior: Clip.hardEdge,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                        ),
                                                        child: FadeInImage(
                                                          image: NetworkImage(
                                                            "$imageBaseURL${_productDetailsList[index0][index1].skus[index].image.productImages}",
                                                          ),
                                                          placeholder: AssetImage("images/logo.jpeg"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 7,
                                                      child: Container(
                                                        // color: Colors.redAccent,
                                                        // width: screenWidth * 0.6,
                                                        margin: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 10.0),
                                                        // 9647965502 149

                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("${_productDetailsList[index0][index1].skus[index].skuName}",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.black,
                                                                    fontSize: screenWidth * 0.04)),
                                                            Container(
                                                              // color: Colors.greenAccent,
                                                              margin: EdgeInsets.only(top: 8.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "Rs. ${_productDetailsList[index0][index1].skus[index].price}/-",
                                                                    style: TextStyle(
                                                                        color: Colors.red[900],
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: screenWidth * 0.04),
                                                                  ),
                                                                  Spacer(),

                                                                  Visibility(
                                                                    visible: _circularProgressVisibility[index0][index1][index],
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 17.0,
                                                                          height: 17.0,
                                                                          child: CircularProgressIndicator(
                                                                            backgroundColor: circularBGCol,
                                                                            strokeWidth: 4,
                                                                            valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: screenWidth * 0.05,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  //addVisibility Product Icon
                                                                  Visibility(
                                                                    visible: _addVisibility[index0][index1][index],
                                                                    child: Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap: () {
                                                                            if (currentVendorId != vendorId && prefs.getString("cart_id") != "") {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  barrierDismissible: false,
                                                                                  builder: (context) {
                                                                                    return AlertDialog(
                                                                                      // title: Text("Give the code?"),
                                                                                      content: Padding(
                                                                                        padding: const EdgeInsets.only(top: 10.0),
                                                                                        child: Text(
                                                                                          "You Have Product in Your Cart of Another Seller.\n"
                                                                                          "Do You Want to Clear Your Cart?",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontSize: 14.0,
                                                                                            // fontWeight: FontWeight.bold
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      actions: [
                                                                                        new FlatButton(
                                                                                            child: const Text(
                                                                                              "Yes, I want",
                                                                                              style: TextStyle(
                                                                                                color: lightThemeRed,
                                                                                                fontSize: 14.0,
                                                                                                // fontWeight: FontWeight.bold
                                                                                              ),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Map _body = {"cartid": prefs.getString("cart_id")};
                                                                                              _cartEmptyBloc.cartItemsEmpty(_body);
                                                                                              currentVendorId = "";
                                                                                              currentCategoryId = "";
                                                                                              prefs.setString("cart_id", "");
                                                                                              prefs.setString("vendor_id", "");
                                                                                              prefs.setString("parent_category_id", "");
                                                                                              Navigator.pop(context);
                                                                                            }),
                                                                                        new FlatButton(
                                                                                            child: const Text(
                                                                                              "No, I Dont",
                                                                                              style: TextStyle(
                                                                                                color: lightThemeRed,
                                                                                                fontSize: 14.0,
                                                                                                // fontWeight: FontWeight.bold
                                                                                              ),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            }),
                                                                                      ],
                                                                                    );
                                                                                  });
                                                                            } else {
                                                                              setState(() {
                                                                                ++_productAmount[index0][index1][index];

                                                                                _circularProgressVisibility[index0][index1][index] =
                                                                                    !_circularProgressVisibility[index0][index1][index];

                                                                                _addVisibility[index0][index1][index] =
                                                                                    !_addVisibility[index0][index1][index];

                                                                                setStateCheck = true;

                                                                                _index0 = index0;
                                                                                _index = index;
                                                                                _index1 = index1;
                                                                                currentVendorId = vendorId;
                                                                                currentCategoryId = categoryId;
                                                                                prefs.setString("vendor_id", vendorId);
                                                                                prefs.setString("parent_category_id", categoryId);
                                                                              });
                                                                              Map body;
                                                                              if (prefs.getString("cart_id") != "") {
                                                                                if (prefs.getString("user_id") == "") {
                                                                                  body = {
                                                                                    "skuid":
                                                                                        "${_productDetailsList[index0][index1].skus[index].id}",
                                                                                    "quantity": "${_productAmount[index0][index1][index]}",
                                                                                    "cartid": prefs.getString("cart_id")
                                                                                  };
                                                                                } else if (prefs.getString("user_id") != "") {
                                                                                  body = {
                                                                                    "skuid":
                                                                                        "${_productDetailsList[index0][index1].skus[index].id}",
                                                                                    "quantity": "${_productAmount[index0][index1][index]}",
                                                                                    "userid": "${prefs.getString("user_id")}",
                                                                                    "cartid": prefs.getString("cart_id")
                                                                                  };
                                                                                }
                                                                              } else if (prefs.getString("cart_id") == "") {
                                                                                if (prefs.getString("user_id") == "") {
                                                                                  body = {
                                                                                    "skuid":
                                                                                        "${_productDetailsList[index0][index1].skus[index].id}",
                                                                                    "quantity": "${_productAmount[index0][index1][index]}"
                                                                                  };
                                                                                } else if (prefs.getString("user_id") != "") {
                                                                                  body = {
                                                                                    "skuid":
                                                                                        "${_productDetailsList[index0][index1].skus[index].id}",
                                                                                    "quantity": "${_productAmount[index0][index1][index]}",
                                                                                    "userid": "${prefs.getString("user_id")}"
                                                                                  };
                                                                                }
                                                                              }
                                                                              _cartItemsAddBloc.cartItemsAdd(body);
                                                                            }
                                                                          },
                                                                          child: Card(
                                                                            margin: EdgeInsets.only(left: 15.0),
                                                                          elevation: 2.0,
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                            child: Container(
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.red[900],width: 1),
                                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(3.0),
                                                                                    child: Icon(
                                                                                      Icons.add,
                                                                                      color: Colors.red[900],
                                                                                      size: 16.0,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.fromLTRB(3.0,3.0,5.0,3.0),
                                                                                    child: Text(
                                                                                      "ADD",
                                                                                      style: new TextStyle(color: Colors.red[900], fontSize: 13.0,
                                                                                      fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ),
                                                                        SizedBox(
                                                                          width: screenWidth * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  //addVisibility and Less Product 2 Icons and Number
                                                                  Visibility(
                                                                    visible: _moreLessVisibility[index0][index1][index],
                                                                    child: Row(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              if (_productAmount[index0][index1][index] == 1) {
                                                                                _moreLessVisibility[index0][index1][index] =
                                                                                    !_moreLessVisibility[index0][index1][index];
                                                                                _addVisibility[index0][index1][index] =
                                                                                    !_addVisibility[index0][index1][index];
                                                                              }
                                                                              --_productAmount[index0][index1][index];
                                                                            });
                                                                            Map body = {
                                                                              "cart_item_id": "${_cartItemId[index0][index1][index]}",
                                                                              "quantity": "${_productAmount[index0][index1][index]}"
                                                                            };
                                                                            _cartItemsUpdateBloc.cartItemsUpdate(body);
                                                                          },
                                                                          child: Icon(
                                                                            Icons.remove_circle_outline,
                                                                            color: lightThemeRed,
                                                                            size: screenWidth * .07,
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: screenWidth * .012),
                                                                        Container(
                                                                            alignment: Alignment.topCenter,
                                                                            // height: screenHeight * .025,
                                                                            // width: screenHeight * .025,
                                                                            child: Center(
                                                                                child: Text(
                                                                              "${_productAmount[index0][index1][index]}",
                                                                              style: TextStyle(fontSize: screenWidth * .04, fontFamily: 'pop'),
                                                                            ))),
                                                                        SizedBox(width: screenWidth * .012),
                                                                        InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              ++_productAmount[index0][index1][index];
                                                                            });
                                                                            Map body = {
                                                                              "cart_item_id": "${_cartItemId[index0][index1][index]}",
                                                                              "quantity": "${_productAmount[index0][index1][index]}"
                                                                            };
                                                                            print(_cartItemId[index0][index1][index]);
                                                                            print("$index1 $index");
                                                                            print(_cartItemId);

                                                                            _cartItemsUpdateBloc.cartItemsUpdate(body);
                                                                          },
                                                                          child: Icon(
                                                                            Icons.add_circle_outline,
                                                                            color: lightThemeRed,
                                                                            size: screenWidth * .07,
                                                                          ),
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
                                                    )
                                                  ],
                                                ),
                                              ));
                                        }),
                                  );
                                  // );
                                }),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: Text(
                      "This Shop Has No Items",
                      style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ));
                  }
                }
                else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Text("No Data Found");
                } else
                  return Center(
                    heightFactor: 5,
                    widthFactor: 10,
                    child: CircularProgressIndicator(
                        backgroundColor: circularBGCol,
                        strokeWidth: strokeWidth,
                        valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)
                    ),
                  );
              },
            ),
          ),
        ],
      )),
    );
  }
}
