import 'package:desichatkara/app_screens/KitchenDetails/Repository/KitchenDetailsRepo.dart';
import 'package:desichatkara/app_screens/KitchenDetails/bloc/AddCartBloc.dart';
import 'package:desichatkara/app_screens/KitchenDetails/bloc/UpdateCartBloc.dart';
import 'package:desichatkara/app_screens/KitchenDetails/model/AddCartModel.dart';
import 'package:desichatkara/app_screens/KitchenDetails/model/KitchenDetailsModel.dart';
import 'package:desichatkara/app_screens/KitchenDetails/model/UpdateCartModel.dart';
import 'file:///D:/STUDY/Android_flutter/desichatkara-flutter-main/desichatkara-flutter-main/lib/app_screens/CartPage/Cart.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Cart1.dart';

class KitchenDetailedMenu1 extends StatefulWidget {
  @override
  _KitchenDetailedMenuState createState() => _KitchenDetailedMenuState();
}

class _KitchenDetailedMenuState extends State<KitchenDetailedMenu1> {
  Future<KitchenDetailsResponseModel> allMenu;
  KitchenDetailRepository _kitchenDetailRepository;

  AddCartBloc _addCartBloc;
  UpdateCartBloc _updateCartBloc;

  var productList = new List<List>();
  var subcategory = new List();
  var alreadyAdded = new List();

  var count = List.generate(15, (i) => List.generate(25, (j) => List.generate(6, (k) => 0)));

  var index1 = -1;
  var index2 = -1;
  var index3 = -1;
  bool _isselected = false;

  var itemCount = 0;

  var selectedSku;

  String cartId, cartItemId, cartIdFromSharedP;

  SharedPreferences preferencesCart;

  bool _isFirst = true;

  //Map body1,body2,body;

  @override
  void initState() {
    super.initState();
    getCartId();
//Map body;

    _addCartBloc = AddCartBloc();
    _updateCartBloc = UpdateCartBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "Gopal Kitchen",
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
          FutureBuilder<KitchenDetailsResponseModel>(
            future: allMenu,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data.cartItems != null) {
                  for (int i = 0; i < snapshot.data.data.cartItems.length; i++) {
                    alreadyAdded.add(snapshot.data.data.cartItems[i]);
                  }

                  //_isselected=true;

                }

                for (int i = 0; i < snapshot.data.data.menu[0].subcategory.length; i++) {
                  var product = new List();

                  for (int j = 0; j < snapshot.data.data.productDetails.length; j++) {
                    if (snapshot.data.data.menu[0].subcategory[i].id == snapshot.data.data.productDetails[j].categoryId) {
                      product.add(snapshot.data.data.productDetails[j]);
                    }
                  }

                  if (product.isNotEmpty) {
                    productList.add(product);
                    subcategory.add(snapshot.data.data.menu[0].subcategory[i]);
                  }
                  //var k=0;

                }

                if (snapshot.data.data.cartItems != null) {
                  for (var p = 0; p < productList.length; p++) {
                    for (var q = 0; q < productList[p].length; q++) {
                      for (var r = 0; r < productList[p][q].skus.length; r++) {
                        for (var k = 0; k < alreadyAdded.length; k++) {
                          if (productList[p][q].skus[r].id == alreadyAdded[k].skuId) {
                            count[p][q][r] = int.parse(alreadyAdded[k].quantity);
                          }
                        }
                      }
                    }
                  }
                }

                //print(alreadyAdded[0]);
                // print(count.toString());

                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subcategory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      subcategory[index].subcategoryname,
                                      style: new TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Icon(Icons.linear_scale, color: Colors.grey),
                                ],
                              ),
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: productList[index].length,
                                itemBuilder: (BuildContext c1, int i1) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          productList[index][i1].name,
                                          style: new TextStyle(color: Colors.black, fontSize: 16.0),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: productList[index][i1].skus.length,
                                            itemBuilder: (BuildContext c2, int i2) {
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
                                                        height: 70.0,
                                                        width: 70.0,

                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(10.0),
                                                              topRight: Radius.circular(10.0),
                                                              bottomLeft: Radius.circular(10.0),
                                                              bottomRight: Radius.circular(10.0)),
                                                          image: DecorationImage(
                                                            image: productList[index][i1].skus[i2].image.productImages == null
                                                                ? AssetImage("images/veg_meal.png")
                                                                : NetworkImage("https://deliveryontime.co.in/api/public" +
                                                                    productList[index][i1].skus[i2].image.productImages),

                                                            //AssetImage("images/pizza.png"),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        //child: Image.asset("images/poke1.jpg")
                                                      ),
                                                      Container(
                                                        width: 120.0,
                                                        margin: EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              productList[index][i1].skus[i2].skuName,
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
                                                                  productList[index][i1].skus[i2].price,
                                                                  style: new TextStyle(color: Colors.black, fontSize: 14.0),
                                                                ),
                                                                Text(
                                                                  "per plate",
                                                                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                          margin: EdgeInsets.only(top: 12.0, bottom: 12.0),
                                                          width: 60.0,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: Colors.green,
                                                                    size: 12.0,
                                                                  ),
                                                                  Text(
                                                                    "4.2",
                                                                    style: new TextStyle(color: Colors.green, fontSize: 12.0),
                                                                  ),
                                                                ],
                                                              ),
                                                              (index1 == index && index2 == i1 && index3 == i2 && _isselected == true) ||
                                                                      alreadyAdded.contains(productList[index][i1].skus[i2]) ||
                                                                      (count[index][i1][i2] > 0 && _isselected == true)
                                                                  ? Container(
                                                                      margin: EdgeInsets.only(top: 22.0, bottom: 8.0),
                                                                      width: 80.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  // itemCount--;
                                                                                  count[index][i1][i2]--;
                                                                                  if (count[index][i1][i2] == 0) {
                                                                                    _isselected = false;
                                                                                    index1 = -1;
                                                                                    index2 = -1;
                                                                                    index3 = -1;
                                                                                  }
                                                                                });

                                                                                Map body3 = {
                                                                                  "cart_item_id": cartItemId,
                                                                                  "quantity": count[index][i1][i2].toString()
                                                                                };
                                                                                _updateCartBloc.updateCart(body3);
                                                                              },
                                                                              child: index1 == index && index2 == i1 && index3 == i2
                                                                                  ? StreamBuilder<ApiResponse<UpdateCartResponseModel>>(
                                                                                      stream: _updateCartBloc.updateCartStream,
                                                                                      builder: (context, snapshot) {
                                                                                        if (snapshot.hasData) {
                                                                                          switch (snapshot.data.status) {
                                                                                            case Status.LOADING:
                                                                                              Center(
                                                                                                child: Container(
                                                                                                  height: 10.0,
                                                                                                  width: 10.0,
                                                                                                  child: CircularProgressIndicator(
                                                                                                    valueColor:
                                                                                                        AlwaysStoppedAnimation<Color>(
                                                                                                            Colors.cyan),
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                              break;

                                                                                            case Status.COMPLETED:
                                                                                              print("updated");
                                                                                              //cartId=snapshot.data.data.data.cartItems[0].cartId.toString();
                                                                                              // cartItemId=snapshot.data.data.data.cartItems[0].cartItemId.toString();
                                                                                              _isFirst = false;
                                                                                              //print("cartid:"+snapshot.data.data.data.cartItems[0].cartId.toString());

                                                                                              /* Future.delayed(Duration(seconds: 1),()
                                             async {
                                                preferencesCart =
    await SharedPreferences.getInstance();
    preferencesCart.setString("cartiddesichatkara",snapshot.data.data.data.cartItems[0].cartId.toString() );


                                             });*/

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
                                                                              count[index][i1][i2].toString(),
                                                                              style: new TextStyle(color: Colors.black, fontSize: 16.0),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  //itemCount=1;
                                                                                  //itemCount++;
                                                                                  //count[index][i1][i2]=1;
                                                                                  count[index][i1][i2]++;
                                                                                });

                                                                                Map body2 = {
                                                                                  "cart_item_id": cartItemId.toString(),
                                                                                  "quantity": count[index][i1][i2].toString()
                                                                                };
                                                                                _updateCartBloc.updateCart(body2);
                                                                              },
                                                                              child: index1 == index && index2 == i1 && index3 == i2
                                                                                  ? StreamBuilder<ApiResponse<UpdateCartResponseModel>>(
                                                                                      stream: _updateCartBloc.updateCartStream,
                                                                                      builder: (context, snapshot) {
                                                                                        if (snapshot.hasData) {
                                                                                          switch (snapshot.data.status) {
                                                                                            case Status.LOADING:
                                                                                              return Center(
                                                                                                child: Container(
                                                                                                  height: 10.0,
                                                                                                  width: 10.0,
                                                                                                  child: CircularProgressIndicator(
                                                                                                    valueColor:
                                                                                                        AlwaysStoppedAnimation<Color>(
                                                                                                            Colors.cyan),
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                              break;

                                                                                            case Status.COMPLETED:
                                                                                              print("updated");
                                                                                              //cartId=snapshot.data.data.data.cartItems[0].cartId.toString();
                                                                                              //cartItemId=snapshot.data.data.data.cartItems[0].cartItemId.toString();
                                                                                              _isFirst = false;
                                                                                              // print("cartid:"+snapshot.data.data.data.cartItems[0].cartId.toString());

                                                                                              /* Future.delayed(Duration(seconds: 1),()
                                             async {
                                                preferencesCart =
    await SharedPreferences.getInstance();
    preferencesCart.setString("cartiddesichatkara",snapshot.data.data.data.cartItems[0].cartId.toString() );


                                             });*/

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
                                                                  : Container(
                                                                      margin: EdgeInsets.only(top: 22.0),
                                                                      decoration: BoxDecoration(border: Border.all(color: Colors.red[900])),
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          setState(() {
                                                                            // itemCount=1;
                                                                            count[index][i1][i2]++;
                                                                            index1 = index;
                                                                            index2 = i1;
                                                                            index3 = i2;
                                                                          });
                                                                          selectedSku = productList[index1][index2].skus[index3].id;
                                                                          Map b1, b2;
                                                                          b1 = {
                                                                            "skuid": selectedSku.toString(),
                                                                            "quantity": count[index][i1][i2].toString(),
                                                                          };
                                                                          b2 = {
                                                                            "skuid": selectedSku.toString(),
                                                                            "quantity": count[index][i1][i2].toString(),
                                                                            "cartid": cartIdFromSharedP.toString()
                                                                          };
                                                                          Map body1 = cartIdFromSharedP == null ? b1 : b2;

                                                                          _addCartBloc.addCart(body1);
                                                                        },
                                                                        child: index1 == index && index2 == i1 && index3 == i2
                                                                            ? StreamBuilder<ApiResponse<AddCartResponseModel>>(
                                                                                stream: _addCartBloc.addCartStream,
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    switch (snapshot.data.status) {
                                                                                      case Status.LOADING:
                                                                                        return Center(
                                                                                          child: Container(
                                                                                            height: 10.0,
                                                                                            width: 10.0,
                                                                                            child: CircularProgressIndicator(
                                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                                  Colors.cyan),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                        break;

                                                                                      case Status.COMPLETED:
                                                                                        print("hello");

                                                                                        Future.delayed(Duration(seconds: 1), () async {
                                                                                          preferencesCart =
                                                                                              await SharedPreferences.getInstance();
                                                                                          preferencesCart.setString(
                                                                                              "cartiddesichatkara",
                                                                                              snapshot.data.data.data.cartItems[0].cartId
                                                                                                  .toString());
                                                                                          _isFirst = false;
                                                                                          cartId = snapshot
                                                                                              .data.data.data.cartItems[0].cartId
                                                                                              .toString();
                                                                                          cartItemId =
                                                                                              snapshot.data.data.data.cartItemId.toString();
                                                                                          print("cartid:" +
                                                                                              snapshot.data.data.data.cartItems[0].cartId
                                                                                                  .toString());
                                                                                          print("cartitemid:" + cartItemId);

                                                                                          setState(() {
                                                                                            _isselected = true;
                                                                                          });
                                                                                        });

                                                                                        break;

                                                                                      case Status.ERROR:
                                                                                        print("error");

                                                                                        break;
                                                                                    }
                                                                                  }

                                                                                  return Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.add,
                                                                                        color: Colors.red[900],
                                                                                        size: 16.0,
                                                                                      ),
                                                                                      Text(
                                                                                        "ADD",
                                                                                        style: new TextStyle(
                                                                                            color: Colors.red[900], fontSize: 14.0),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                })
                                                                            : Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.add,
                                                                                    color: Colors.red[900],
                                                                                    size: 16.0,
                                                                                  ),
                                                                                  Text(
                                                                                    "ADD",
                                                                                    style: new TextStyle(
                                                                                        color: Colors.red[900], fontSize: 14.0),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                      ),
                                                                    )
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  );
                                })
                          ],
                        ),
                      );
                    });
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
            },
          ),
        ],
      ),
    );
  }

  getCartId() async {
    preferencesCart = await SharedPreferences.getInstance();
    cartIdFromSharedP = preferencesCart.getString("cartiddesichatkara");

    _kitchenDetailRepository = KitchenDetailRepository();
    cartIdFromSharedP == null
        ? allMenu = _kitchenDetailRepository.getMenu()
        : allMenu = _kitchenDetailRepository.getMenuWithCartId(cartIdFromSharedP);

    setState(() {});
  }
}
