import 'package:desichatkara/app_screens/CartPage/model/ShowCartItemModel.dart';
import 'package:desichatkara/app_screens/CartPage/repository/ShowCartItemRepo.dart';
import 'package:desichatkara/app_screens/KitchenDetails/bloc/UpdateCartBloc.dart';
import 'package:desichatkara/app_screens/KitchenDetails/model/UpdateCartModel.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart1 extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart1> {
  Future<ShowCartItemResponseModel> showCartItems;
  ShowCartItemRepository _showCartItemRepository;

  UpdateCartBloc _updateCartBloc;

  SharedPreferences preferencesCart;
  String cartId;

  var count = new List<int>();
  var cartItemId = new List<String>();
  var i = -1;

  var total_amount, delivery_charge, total;

  @override
  void initState() {
    super.initState();
    getCartId();
    _updateCartBloc = UpdateCartBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CartAppBar(""),
        body: FutureBuilder<ShowCartItemResponseModel>(
            future: showCartItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                total_amount = snapshot.data.data.cartTotalAmount;
                delivery_charge = snapshot.data.data.deliveryFee;
                total = snapshot.data.data.totalIncludingTaxDelivery;
                for (var i = 0; i < snapshot.data.data.cartItems.length; i++) {
                  count.add(int.parse(snapshot.data.data.cartItems[i].quantity));
                }

                for (var j = 0; j < snapshot.data.data.cartItems.length; j++) {
                  cartItemId.add(snapshot.data.data.cartItems[j].cartItemId);
                }
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: int.parse(snapshot.data.data.cartItemCount),
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              // margin: EdgeInsets.only(left:3.0,right:3.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 2.0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(8.0),
                                      height: 65.0,
                                      width: 65.0,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                        image: DecorationImage(
                                          image: snapshot.data.data.cartItems[index].productImage == null
                                              ? AssetImage("images/veg_meal.png")
                                              : NetworkImage("https://deliveryontime.co.in/api/public" +
                                                  snapshot.data.data.cartItems[index].productImage),

                                          //AssetImage("images/pizza.png"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      //child: Image.asset("images/poke1.jpg")
                                    ),
                                    Container(
                                      width: 130.0,
                                      margin: EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.data.cartItems[index].productName,
                                            style: new TextStyle(color: Colors.black, fontSize: 14.0),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                            child: Text(
                                              "1 plate",
                                              style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data.data.cartItems[index].unitPrice,
                                                style: new TextStyle(color: Colors.black, fontSize: 14.0),
                                              ),

                                              /*Text("per plate", style: new TextStyle(color: Colors.grey,
                       fontSize: 14.0),),*/
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 22.0, bottom: 8.0),
                                        width: 80.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    count[index]--;
                                                    i = index;
                                                  });

                                                  Map body3 = {
                                                    "cart_item_id": cartItemId[index].toString(),
                                                    "quantity": count[index].toString()
                                                  };
                                                  _updateCartBloc.updateCart(body3);
                                                },
                                                child: i == index
                                                    ? StreamBuilder<ApiResponse<UpdateCartResponseModel>>(
                                                        stream: _updateCartBloc.updateCartStream,
                                                        builder: (context, snapshot1) {
                                                          if (snapshot1.hasData) {
                                                            switch (snapshot1.data.status) {
                                                              case Status.LOADING:
                                                                Center(
                                                                  child: Container(
                                                                    height: 10.0,
                                                                    width: 10.0,
                                                                    child: CircularProgressIndicator(
                                                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                                                                    ),
                                                                  ),
                                                                );
                                                                break;

                                                              case Status.COMPLETED:
                                                                print("updated");
                                                                total_amount = snapshot1.data.data.data.cartTotalAmount;
                                                                delivery_charge = snapshot1.data.data.data.deliveryFee;
                                                                total = snapshot1.data.data.data.totalIncludingTaxDelivery;

                                                                break;

                                                              case Status.ERROR:
                                                                print("error");

                                                                break;
                                                            }
                                                          }
                                                          return Icon(
                                                            Icons.remove_circle,
                                                            color: Colors.red[900],
                                                          );
                                                        })
                                                    : Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red[900],
                                                      )),
                                            Container(
                                              margin: EdgeInsets.only(left: 1.0, right: 1.0),
                                              child: Text(
                                                count[index].toString(),
                                                style: new TextStyle(color: Colors.black, fontSize: 16.0),
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    count[index]++;
                                                    i = index;
                                                  });

                                                  Map body2 = {
                                                    "cart_item_id": cartItemId[index].toString(),
                                                    "quantity": count[index].toString()
                                                  };
                                                  _updateCartBloc.updateCart(body2);
                                                },
                                                child: i == index
                                                    ? StreamBuilder<ApiResponse<UpdateCartResponseModel>>(
                                                        stream: _updateCartBloc.updateCartStream,
                                                        builder: (context, snapshot2) {
                                                          if (snapshot2.hasData) {
                                                            switch (snapshot2.data.status) {
                                                              case Status.LOADING:
                                                                return Center(
                                                                  child: Container(
                                                                    height: 10.0,
                                                                    width: 10.0,
                                                                    child: CircularProgressIndicator(
                                                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                                                                    ),
                                                                  ),
                                                                );
                                                                break;

                                                              case Status.COMPLETED:
                                                                print("updated");
                                                                total_amount = snapshot2.data.data.data.cartTotalAmount;
                                                                delivery_charge = snapshot2.data.data.data.deliveryFee;
                                                                total = snapshot2.data.data.data.totalIncludingTaxDelivery;

                                                                break;

                                                              case Status.ERROR:
                                                                print("error");

                                                                break;
                                                            }
                                                          }
                                                          return Icon(
                                                            Icons.add_circle,
                                                            color: Colors.red[900],
                                                          );
                                                        })
                                                    : Icon(
                                                        Icons.add_circle,
                                                        color: Colors.red[900],
                                                      )),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      height: 80.0,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .20),
                      color: Colors.yellow[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "Delivery at",
                                      style: new TextStyle(color: Colors.white, fontSize: 14.0),
                                    ),
                                  ),
                                ),
                                Text(
                                  "change",
                                  style: new TextStyle(color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.white),
                                  Text(
                                    "ABC building , z road, delhi 54",
                                    style: new TextStyle(color: Colors.white, fontSize: 14.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      height: 70.0,
                      margin: EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Item Total",
                                  style: new TextStyle(color: Colors.black, fontSize: 14.0),
                                ),
                              ),
                              Text(
                                total_amount,
                                style: new TextStyle(color: Colors.black, fontSize: 14.0),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Delivery Charge",
                                    style: new TextStyle(color: Colors.black, fontSize: 14.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    delivery_charge,
                                    style: new TextStyle(color: Colors.green, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      height: 50.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total",
                              style: new TextStyle(color: Colors.black, fontSize: 14.0),
                            ),
                          ),
                          Text(
                            total,
                            style: new TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                      child: Center(child: Text("Place Order", style: new TextStyle(color: Colors.white, fontSize: 16.0))),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                print("hello");
                return Container(
                  child: Center(
                      child: Text(
                    "No Data ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  getCartId() async {
    preferencesCart = await SharedPreferences.getInstance();
    cartId = preferencesCart.getString("cart_id");

    Map body;

    body = {"cartid": cartId.toString()};

    _showCartItemRepository = ShowCartItemRepository();
    showCartItems = _showCartItemRepository.showCartItem(body);

    setState(() {});
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
  })  : preferredSize = Size.fromHeight(140.0),
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
          Container(
            color: Color.fromRGBO(130, 2, 14, 1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .09,
            child: Container(
              margin: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color.fromRGBO(223, 148, 20, 1),
                  ),
                  Expanded(
                      child: Text(
                    "KRISHNA NAGAR DELHI-II",
                    style: new TextStyle(color: Colors.white, fontSize: 14.0),
                  )),
                  Text(
                    "change",
                    style: new TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
