import 'package:desichatkara/app_screens/CartPage/Cart.dart';
import 'package:desichatkara/app_screens/Home/model/ActiveCuponModel.dart';
import 'package:desichatkara/app_screens/Home/model/AllCategoryModel.dart';
import 'package:desichatkara/app_screens/Home/model/KitchenNearModel.dart';
import 'package:desichatkara/app_screens/Home/repository/ActiveCuponRepo.dart';
import 'package:desichatkara/app_screens/Home/repository/AllCategoryRepo.dart';
import 'package:desichatkara/app_screens/Home/repository/KitchenNearRepo.dart';
import 'package:desichatkara/app_screens/KitchenByCategory/KitchenByCategory.dart';
import 'package:desichatkara/app_screens/orderDetails_screen/OrderHistory.dart';
import 'package:desichatkara/app_screens/screens/PickLocation.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:desichatkara/app_screens/screens/AddressList.dart';
import 'package:desichatkara/app_screens/screens/KitchenDetailedMenu.dart';
import 'package:desichatkara/app_screens/screens/UserProfile.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  String address;

  Home({this.address});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller;

  // PageController controller2;
  // int currentPageValue = 0;
  // int currentPageValue2 = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  Future<KitchensNearResponseModel> allKitchenNear;
  KitchensNearRepository _kitchenNearRepository;

  Future<AllCategoryResponseModel> allCategory;
  AllCategoryRepository _allCategoryRepository;

  Future<ActiveCuponResponseModel> activeCupon;
  ActiveCuponRepository _activeCuponRepository;

  SharedPreferences prefs;
  String name = "";
  String email = "";
  String address;
  List<String> bannerImages = [
    'images/beverages.png',
    'images/diet.png',
    'images/sweet.png',
    'images/snacks.png'
  ];

  List<String> vendorImages = [
    'images/tasty.png',
    'images/new.png',
    'images/gopal.png'
  ];

  openPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Form(
                  // key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Enter your Email',
                              prefixIcon: Icon(Icons.email_outlined)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Enter your number',
                              prefixIcon: Icon(Icons.phone)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.red[900],
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            print("Close Submit");
                            Navigator.pop(context);
                            // if (_formKey.currentState.validate()) {
                            //   _formKey.currentState.save();
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name");
    email = prefs.getString("email");
    print(prefs.getString("name"));
    setState(() {});
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      address = first.addressLine;
      print("Address:" + address);
    });
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
    controller = PageController();
    Map body;

    _kitchenNearRepository = KitchensNearRepository();
    allKitchenNear = _kitchenNearRepository.getAllKitchenNear("2");

    _activeCuponRepository = ActiveCuponRepository();
    activeCupon = _activeCuponRepository.getactiveCupon();

    _allCategoryRepository = AllCategoryRepository();
    allCategory = _allCategoryRepository.getAllCategory();
    if (widget.address == null) {
      getLocation();
    } else {
      address = widget.address;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    // controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        drawer: Drawer(
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: Container(
                  height: 150.0,
                  color: Color.fromRGBO(143, 23, 35, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'images/profile.png',
                          width: 75.0,
                          height: 75.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 50.0),
                        child: Column(
                          children: [
                            Text(
                              "$name",
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "$email",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                  leading: const Icon(
                    Icons.notifications_on_outlined,
                    color: Colors.black,
                  ),
                  title: const Text("Notifications"),
                  onTap: () {
                    /* react to the tile being tapped */
                  }),
              Padding(
                padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                child: ListTile(
                    leading: const Icon(
                      Icons.favorite_outline,
                      color: Colors.black,
                    ),
                    title: const Text("Favourite Kitchens"),
                    onTap: () {
                      /* react to the tile being tapped */
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                child: ListTile(
                    leading: const Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                    title: const Text("Orders"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderHistory()));
                    }),
              ),
              ListTile(
                  leading: const Icon(Icons.location_on_outlined,
                      color: Colors.black),
                  title: const Text("My address"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddressList()));
                  }),
              Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Divider()),
              Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "About us",
                    style: new TextStyle(color: Colors.grey),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
                  child: Text(
                    "Contact us",
                    style: new TextStyle(color: Colors.grey),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
                  child: Text(
                    "Concelations and refunds",
                    style: new TextStyle(color: Colors.grey),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
                  child: Text(
                    "FAQS",
                    style: new TextStyle(color: Colors.grey),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Privacy",
                    style: new TextStyle(color: Colors.grey),
                  )),
            ],
          ),
        ),
        appBar: CustomAppBar(
          height: screenHeight * 0.13,
          child: Container(
            height: 100.0,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: AppBar(
                      centerTitle: false,
                      titleSpacing: 0,
                      backgroundColor: Colors.white,
                      bottomOpacity: 0.0,
                      elevation: 0.0,
                      leading: IconButton(
                        onPressed: () => _key.currentState.openDrawer(),
                        icon: Icon(
                          Icons.menu,
                          color: Color.fromRGBO(223, 148, 20, 1),
                        ),
                      ),
                      title: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        // height: 75.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color.fromRGBO(223, 148, 20, 1),
                            ),
                            Expanded(
                                child: address == null
                                    ? Text('',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15))
                                    : Text(address,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15))),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MapCurrentAddressPicker()));
                              },
                              child: Text(
                                "change",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_active_outlined,
                              color: Color.fromRGBO(223, 148, 20, 1),
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 5,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 50.0,
                      child: Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey[300], width: 1),
                        ),
                        //elevation: 2.0,

                        child: Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    )),
                                Expanded(
                                  child: TextField(
                                    //controller: _searchQuery,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,

                                        // prefixIcon: new Icon(Icons.search, color: Colors.grey[600]),
                                        hintText: "Search kitchens and dishes",
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[600])),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              height: 180.0,
              child: PageIndicatorContainer(
                pageView: PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: 4,
                  onPageChanged: (int page) {
                    //getChangedPageAndMoveBar(page);
                  },
                  controller: controller,
                  itemBuilder: (context, index) {
                    return Container(
                      //margin: EdgeInsets.only(right: 2, left: 2),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(bannerImages[index]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
                length: 4,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Text(
                "Offers for you",
                style: new TextStyle(
                    color: Colors.black, fontWeight: font_bold, fontSize: 16),
              ),
            ),
            FutureBuilder<ActiveCuponResponseModel>(
              future: activeCupon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 160.0,
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: ListView.builder(
                        cacheExtent: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.data.length,
                        /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 3.0),*/
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 140.0,
                            height: 160.0,
                            margin: EdgeInsets.only(left: 3.0, right: 3.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2.0,
                              child: Container(
                                //height: 160.0,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0)),
                                  image: DecorationImage(
                                    image: NetworkImage(imageBaseURL +
                                        snapshot
                                            .data.data[index].couponBannerUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // child: FadeInImage(
                                //   image: NetworkImage(
                                //       imageBaseURL+snapshot.data.data[index].couponBannerUrl
                                //     ),
                                //     placeholder: AssetImage("images/veg_meal.png"),
                                //     fit: BoxFit.fill,
                                // ),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  print("error");
                  return Container(
                    child: Center(
                        child: Text(
                      "No Data ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Kitchens Near You",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: font_bold,
                              fontSize: 16),
                        )),
                      ],
                    ),
                  ),
                  FutureBuilder<KitchensNearResponseModel>(
                    future: allKitchenNear,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            cacheExtent: 10,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.data.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext ctxt, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            KitchenDetailedMenu(
                                                categoryId: snapshot.data
                                                    .data[index].categoryId,
                                                vendorId: snapshot
                                                    .data.data[index].vendorId,
                                                vendorName: snapshot.data
                                                    .data[index].shopName)),
                                  );
                                },
                                child: Container(
                                  height: 220,
                                  margin: index == snapshot.data.data.length - 1
                                      ? EdgeInsets.only(
                                          left: 10.0, right: 10.0, bottom: 0)
                                      : EdgeInsets.only(
                                          left: 10.0, right: 10.0, bottom: 20),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 2.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 150.0,
                                              width: screenWidth,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(15.0),
                                                  topRight:
                                                      Radius.circular(15.0),
                                                ),
                                              ),
                                              child: FadeInImage(
                                                image:
                                                    // NetworkImage(
                                                    //   // imageBaseURL+ snapshot.data.data[index].vendorImage,
                                                    // ),
                                                    AssetImage(vendorImages[
                                                        index % 3]),
                                                placeholder: AssetImage(
                                                    "images/logo.jpeg"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 2.5, 5, 2.5),
                                                  color: Colors.red[800],
                                                  child: Text(
                                                    "Flat 30% OFF",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )),
                                            Positioned(
                                                bottom: 10,
                                                right: 10,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 2.5, 5, 2.5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    "47 mins",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                )),
                                            Positioned(
                                                top: 10,
                                                right: 10,
                                                child: ClipOval(
                                                  child: Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white70),
                                                    child: Icon(
                                                      Icons.bookmark_border,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0,
                                              top: 10.0,
                                              right: 10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                snapshot
                                                    .data.data[index].shopName,
                                                style: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              )),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    255, 165, 0, 1),
                                                size: 15.0,
                                              ),
                                              Text(
                                                "4.2",
                                                style: new TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "/5",
                                                style: new TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 5.0),
                                            child: Text(
                                              "veg, Lunch",
                                              style: new TextStyle(
                                                  color: Colors.grey),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        print("error");
                        return Container(
                          child: Center(
                              child: Text(
                            "No Data ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Order Your Choice",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: font_bold,
                              fontSize: 16),
                        )),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: FutureBuilder<AllCategoryResponseModel>(
                        future: allCategory,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              cacheExtent: 10,
                              shrinkWrap: true,
                              itemCount:
                                  snapshot.data.data[0].subcategory.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: .9),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KitchenByCategory(snapshot.data
                                                  .data[0].subcategory[index].id
                                                  .toString())),
                                    );
                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                      ),
                                      elevation: 1.0,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(7.5),
                                                    topRight:
                                                        Radius.circular(7.5)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      imageBaseURL +
                                                          snapshot
                                                              .data
                                                              .data[0]
                                                              .subcategory[
                                                                  index]
                                                              .categoryImage),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            child: Center(
                                              child: Text(
                                                snapshot
                                                    .data
                                                    .data[0]
                                                    .subcategory[index]
                                                    .subcategoryname,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: font_bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                      // ignore: dead_code
                                      ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            print("hello");
                            return Container(
                              child: Center(
                                  child: Text(
                                "No Data ",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ))
                ],
              ),
            ),
            InkWell(
              onTap: openPopUp,
              child: Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                height: 180.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/orange_banner.png'),
                        fit: BoxFit.fill)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      //  color: Colors.white70,
      alignment: Alignment.center,
      child: child,
    );
  }
}
