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
//import 'package:desichatkara/app_screens/Home/model/KitchenNearModel.dart';
import 'package:desichatkara/app_screens/screens/AddressList.dart';
import 'package:desichatkara/app_screens/screens/BestSellingKitchens.dart';
import 'package:desichatkara/app_screens/screens/KitchenDetailedMenu.dart';
import 'package:desichatkara/app_screens/screens/KitchenDetailedMenu1.dart';
import 'package:desichatkara/app_screens/screens/KitchensNearYou.dart';
import 'package:desichatkara/app_screens/screens/OrderYourChoice.dart';
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
  String name="";
  String email="";
  String address;
  List<String> bannerImages = [
    'images/pav.png',
    'images/momo.png',
    'images/sweet.png',
    'images/idly.png'
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
                // Positioned(
                //   right: -40.0,
                //   top: -40.0,
                //   child: InkWell(
                //     onTap: () {
                //       print("Close");
                //       Navigator.of(context).pop();
                //     },
                //     child: CircleAvatar(
                //       child: Icon(Icons.close),
                //       backgroundColor: Colors.red,
                //     ),
                //   ),
                // ),
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
                            prefixIcon: Icon(
                              Icons.email_outlined
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Enter your number',
                              prefixIcon: Icon(
                                  Icons.phone
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.red[900],
                          child: Text("Submit", style: TextStyle(
                            color: Colors.white
                          ),),

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
    name=prefs.getString("name");
    email=prefs.getString("email");
    print(prefs.getString("name"));
    setState(() {

    });
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
      print("Address:"+address);
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
    if(widget.address == null) {
      getLocation();
    }
    else {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
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
                              style: new TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "$email",
                                style: new TextStyle(color: Colors.white, fontSize: 14.0),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistory()));
                    }),
              ),
              ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: Colors.black),
                  title: const Text("My address"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddressList()));
                  }),
              Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0), child: Divider()),
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
        appBar: HomeAppBar(
          _key,
          "",
        ),
        body: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              color: Color.fromRGBO(130, 2, 14, 1),
              width: MediaQuery.of(context).size.width,
              height: 75.0,
              child: Container(
                margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(223, 148, 20, 1),
                    ),
                    Expanded(
                        child: address == null ?
                      Text('',
                        style: TextStyle(color: Colors.white)
                      ) :
                      Text(address,
                          style: TextStyle(color: Colors.white)
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context) => MapCurrentAddressPicker())
                          );
                        },
                        child: Text(
                          "change",
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 180.0,
             // margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
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

            /*Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0
              ),
              height: 130.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 100.0,
                    // color: Colors.redAccent,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Column(
                          children: [
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Image(
                                image: AssetImage('images/leaf.png'),
                                height: 40.0,
                                width: 40.0)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 15.0, bottom: 8.0),
                          child: Text(
                            "Pure Veg",
                            style: new TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Column(children: [
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Image(
                                image: AssetImage('images/max.png'),
                                height: 40.0,
                                width: 40.0)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 15.0, bottom: 8.0),
                          child: Text(
                            "MAX Safety",
                            style: new TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Column(children: [
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Image(
                                image: AssetImage('images/pro.png'),
                                height: 40.0,
                                width: 40.0)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 15.0, bottom: 8.0),
                          child: Text(
                            "Pro",
                            style: new TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Column(children: [
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Image(
                                image: AssetImage('images/trending.png'),
                                height: 40.0,
                                width: 40.0)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 15.0, bottom: 8.0),
                          child: Text(
                            "Trending",
                            style: new TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              ),
            ),*/

            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Text(
                "Offers for you",
                style: new TextStyle(
                    color: Colors.black,
                    fontWeight: font_bold,
                    fontSize: 16
                ),
              ),
            ),

            FutureBuilder<ActiveCuponResponseModel>(
              future:activeCupon,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return  Container(
                    height: 160.0,
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection:Axis.horizontal ,
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
                                    image: snapshot.data.data[index].couponBannerUrl == null
                                        ? AssetImage("images/veg_meal.png")
                                        : NetworkImage(
                                        imageBaseURL+snapshot.data.data[index].couponBannerUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                //child: Image.asset("images/poke1.jpg")
                              ),
                            ),
                          );
                        }),
                  );
                }
                else if(snapshot.hasError){
                  print("error");
                  return Container(
                    child: Center(
                        child: Text(
                          "No Data ",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
              },

            ),

            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                            "Kitchens Near You",
                            style: new TextStyle(
                                color: Colors.black,
                                fontWeight: font_bold,
                                fontSize: 16
                            ),
                          )
                        ),
                        // InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(builder: (context) => KitchensNearYou()),
                        //       );
                        //     },
                        //     child: Text(
                        //       "see all",
                        //       style: TextStyle(
                        //         color: Colors.red,
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 17
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                  FutureBuilder<KitchensNearResponseModel>(
                    future: allKitchenNear,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
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
                                        builder: (context) => KitchenDetailedMenu(
                                            categoryId: snapshot.data.data[index].categoryId,
                                            vendorId: snapshot.data.data[index].vendorId,
                                            vendorName: snapshot.data.data[index].shopName)
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 220,
                                  margin: index == snapshot.data.data.length -1 ? EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0) : EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 2.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 150.0,
                                              width: screenWidth,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15.0),
                                                  topRight: Radius.circular(15.0),
                                                ),
                                              ),
                                                child: FadeInImage(
                                                    image:
                                                    // NetworkImage(
                                                    //   // imageBaseURL+ snapshot.data.data[index].vendorImage,
                                                    // ),
                                                    AssetImage(vendorImages[index % 3]),
                                                    placeholder: AssetImage("images/logo.jpeg"),
                                                    fit: BoxFit.fill,
                                                  ),
                                              ),
                                            Positioned(
                                              bottom: 0,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
                                                  color: Colors.red[800],
                                                  child: Text("Flat 30% OFF", style: TextStyle(
                                                        color: Colors.white
                                                      ),
                                                  ),
                                                )
                                            ),
                                            Positioned(
                                              bottom: 10,
                                                right: 10,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white54,
                                                    borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Text("47 mins", style: GoogleFonts.poppins(

                                                    ),
                                                  ),
                                                )
                                            ),
                                            Positioned(
                                              top: 10,
                                                right: 10,
                                                child: ClipOval(
                                                  child: Container(
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white70
                                                    ),
                                                    child: Icon(
                                                      Icons.bookmark_border,
                                                      size: 20,
                                                    ),
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, top: 10.0, right: 10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                  snapshot.data.data[index].shopName,
                                                  style: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16
                                                  ),
                                                )
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(255, 165, 0, 1),
                                                size: 15.0,
                                              ),
                                              Text(
                                                "4.2",
                                                style: new TextStyle(
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                "/5",
                                                style: new TextStyle(
                                                    color: Colors.grey
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                                            child: Text(
                                              "veg, Lunch",
                                              style: new TextStyle(color: Colors.grey),
                                            )
                                        ),
                                        // Padding(
                                        //     padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                        //     child: Text(
                                        //       "brakefast, dinner",
                                        //       style: new TextStyle(color: Colors.grey),
                                        //     ))
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
            ),

            // Container(
            //   margin: EdgeInsets.only(top: 10.0),
            //   child: Column(
            //     children: [
            //       Container(
            //         margin: EdgeInsets.only(left: 10.0, right: 10.0),
            //         child: Row(
            //           children: [
            //             Expanded(
            //                 child: Text(
            //               "Best Selling Kitchens",
            //               style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            //             )),
            //             InkWell(
            //                 onTap: () {
            //                   // Navigator.push(
            //                   //   context,
            //                   //   MaterialPageRoute(builder: (context) => BestSellingKitchens()),
            //                   // );
            //                 },
            //                 child: Text(
            //                   "see all",
            //                   style: new TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            //                 ))
            //           ],
            //         ),
            //       ),
            //       Container(
            //         height: 170.0,
            //         padding: EdgeInsets.only(left: 8.0, right: 8.0),
            //         margin: EdgeInsets.only(left: 3.0, right: 3.0),
            //         child: new ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: 6,
            //             itemBuilder: (BuildContext ctxt, int index) {
            //               return InkWell(
            //                 onTap: () {
            //
            //                 },
            //                 child: Container(
            //                   width: 150.0,
            //                   height: 180.0,
            //                   margin: EdgeInsets.only(left: 3.0, right: 3.0),
            //                   child: Card(
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(10.0),
            //                     ),
            //                     elevation: 2.0,
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           height: 80.0,
            //
            //                           decoration: BoxDecoration(
            //                             borderRadius: BorderRadius.only(
            //                               topLeft: Radius.circular(10.0),
            //                               topRight: Radius.circular(10.0),
            //                             ),
            //                             image: DecorationImage(
            //                               image: AssetImage("images/veg_meal.png"),
            //                               fit: BoxFit.cover,
            //                             ),
            //                           ),
            //                           //child: Image.asset("images/poke1.jpg")
            //                         ),
            //                         Container(
            //                           margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 2.0),
            //                           child: Row(
            //                             children: [
            //                               Expanded(
            //                                   child: Text(
            //                                 "Gopal Kitchen",
            //                                 style: new TextStyle(color: Colors.black),
            //                               )),
            //                               Text(
            //                                 "4.2",
            //                                 style: new TextStyle(color: Colors.green),
            //                               )
            //                             ],
            //                           ),
            //                         ),
            //                         Container(
            //                             margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0, bottom: 3.0),
            //                             child: Text(
            //                               "veg, Lunch",
            //                               style: new TextStyle(color: Colors.grey),
            //                             )),
            //                         Container(
            //                             margin: EdgeInsets.only(left: 5.0, right: 5.0),
            //                             child: Text(
            //                               "brakefast, dinner",
            //                               style: new TextStyle(color: Colors.grey),
            //                             ))
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             }),
            //       ),
            //     ],
            //   ),
            // ),

            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child:
                            Text(
                            "Order Your Choice",
                              style: new TextStyle(
                                color: Colors.black,
                                fontWeight: font_bold,
                                fontSize: 16
                              ),
                          )
                        ),
                        // InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(builder: (context) => OrderYourChoice()),
                        //       );
                        //     },
                        //     child: Text(
                        //       "see all",
                        //       style: new TextStyle(
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 17
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:
                    FutureBuilder<AllCategoryResponseModel>(
                      future: allCategory,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.data[0].subcategory.length,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: .9
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => KitchenByCategory(snapshot.data.data[0].subcategory[index].id.toString())),
                                  );
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.5),
                                    ),
                                    elevation: 1.0,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7.5), topRight: Radius.circular(7.5)),
                                              image: DecorationImage(
                                                image: snapshot.data.data[0].subcategory[index].categoryImage == null
                                                    ? AssetImage("images/veg_meal.png")
                                                    : NetworkImage(
                                                    imageBaseURL+snapshot.data.data[0].subcategory[index].categoryImage),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                                snapshot.data.data[0].subcategory[index].subcategoryname,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: font_bold,
                                                  fontSize: 12
                                                ),
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
                        }
                        else if(snapshot.hasError){
                          print("hello");
                          return Container(
                            child: Center(
                                child: Text(
                                  "No Data ",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                )),
                          );
                        }
                        else{
                          return Center(child: CircularProgressIndicator());
                        }
                      },

                    )



                  )
                ],
              ),
            ),

           /* Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              height: 200.0,
              child: PageIndicatorContainer(
                pageView: PageView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: 4,
                  onPageChanged: (int page) {
                    //getChangedPageAndMoveBar(page);
                  },
                  controller: new PageController(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Container(margin: EdgeInsets.only(top: 10.0), child: Text("Customers Feedback"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15.0, top: 20.0),
                                child:
                                    /*CircleAvatar(
  radius: 50,
  backgroundImage: NetworkImage('https://via.placeholder.com/140x100')
),*/

                                    ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'images/sonam.png',
                                    width: 95.0,
                                    height: 95.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 25.0, top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(width: 200.0, child: Text("I'M LOOSING WEIGHT THE PROPER WAY")),
                                    Container(
                                        margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: Text(
                                          "Thanks to DesicChatkara",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    Text(
                                      "Sonam Garg",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                length: 4,
              ),
            ),*/


            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            //   child: Container(
            //     height: 85.0,
            //     color:darkThemeRed,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(0, 20, 0,0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //           Text(
            //             "CORPORATE CATERING",
            //             style: TextStyle(fontSize: 16, fontWeight:font_semibold,color: Colors.white),
            //           ),
            //           Padding(
            //             padding:EdgeInsets.only(top: 5.0),
            //             child: Text(
            //               "We cater to all orders over 10 people or more",
            //               style: TextStyle(fontSize: 10, fontWeight: font_semibold,color: Colors.white),
            //             ),
            //           )
            //         ],),
            //       ),
            //       Card(
            //         margin: EdgeInsets.fromLTRB(5, 20, 0, 0),
            //         color: Colors.white,
            //         child: Padding(
            //           padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            //           child: Text(
            //             "CONTACT US",
            //             style: TextStyle(fontSize: 12, fontWeight: font_semibold,color: darkThemeRed),
            //           ),
            //         ),
            //       )
            //     ],),
            //   ),
            // )

            InkWell(
              onTap: openPopUp,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 180.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/orange_banner.png'),
                    fit: BoxFit.fill
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  GlobalKey<ScaffoldState> gkey;

  @override
  final Size preferredSize;

  final String title;

  HomeAppBar(
      this.gkey,
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(100.0),
        super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState(gkey: gkey);
}

class _HomeAppBarState extends State<HomeAppBar> {
  GlobalKey<ScaffoldState> gkey;

  _HomeAppBarState({this.gkey});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        color: Color.fromRGBO(143, 23, 35, 1),
        child: Stack(
          children: <Widget>[
            Container(
                color: Color.fromRGBO(143, 23, 35, 1),
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: AppBar(
                  backgroundColor: Color.fromRGBO(143, 23, 35, 1),
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  leading: InkWell(
                      onTap: (){
                        gkey.currentState.openDrawer();
                      },
                      child: Icon(Icons.menu, color: Colors.white)
                  ),

                  title: Image.asset("images/logo.png",height: 35,),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_active_outlined, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                      },
                      icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
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
                              child: new TextField(
                                //controller: _searchQuery,
                                style: new TextStyle(
                                  color: Colors.grey[600],
                                ),
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,

                                    // prefixIcon: new Icon(Icons.search, color: Colors.grey[600]),
                                    hintText: "Search kitchens and dishes",

                                    hintStyle: new TextStyle(color: Colors.grey[600])),
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
      );
  }
}

/*class SearchList extends StatefulWidget {
  SearchList({ Key key }) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();

}

class _SearchListState extends State<SearchList>
{
  Widget appBarTitle = new Text("Search", style: new TextStyle(color: Colors.grey[600],fontSize: 16.0),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.grey[600],);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    init();

  }

  void init() {
    _list = List();
    _list.add("Google");
    _list.add("IOS");
    _list.add("Andorid");
    _list.add("Dart");
    _list.add("Flutter");
    _list.add("Python");
    _list.add("React");
    _list.add("Xamarin");
    _list.add("Kotlin");
    _list.add("Java");
    _list.add("RxAndroid");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _IsSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact))
          .toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String  name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact))
          .toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return Row(children: [
         appBarTitle,

         new IconButton(icon: actionIcon, onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close, color: Colors.grey[600],);
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.grey[600],

                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.grey[600]),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.grey[600])
                    ),
                  );
                  _handleSearchStart();
                }
                else {
                  _handleSearchEnd();
                }
              });
            },),

    ],);
    
    
    
    
    
    
    PreferredSize(
      preferredSize: Size.fromHeight(35.0),
          child: new AppBar(
        
        bottomOpacity: 0.0,
                       elevation: 0.0,
        backgroundColor: Colors.white,
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(icon: actionIcon, onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close, color: Colors.grey[600],);
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.grey[600],

                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.grey[600]),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.grey[600])
                    ),
                  );
                  _handleSearchStart();
                }
                else {
                  _handleSearchEnd();
                }
              });
            },),
          ]
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.grey[600],size: 20.0,);
      this.appBarTitle =
      new Text("Search", style: new TextStyle(color: Colors.grey[600],fontSize: 16.0),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

}

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(this.name));
  }

}*/
