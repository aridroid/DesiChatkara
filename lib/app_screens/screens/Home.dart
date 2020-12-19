import 'package:desichatkara/app_screens/Home/model/KitchenNearModel.dart';
import 'package:desichatkara/app_screens/Home/repository/KitchenNearRepo.dart';

//import 'package:desichatkara/app_screens/Home/model/KitchenNearModel.dart';
import 'package:desichatkara/app_screens/screens/AddressList.dart';
import 'package:desichatkara/app_screens/screens/BestSellingKitchens.dart';
import 'package:desichatkara/app_screens/screens/Cart.dart';
import 'package:desichatkara/app_screens/screens/KitchenDetailedMenu.dart';
import 'package:desichatkara/app_screens/screens/KitchenDetailedMenu1.dart';
import 'package:desichatkara/app_screens/screens/KitchensNearYou.dart';
import 'package:desichatkara/app_screens/screens/OrderHistory.dart';
import 'package:desichatkara/app_screens/screens/OrderYourChoice.dart';
import 'package:desichatkara/app_screens/screens/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_indicator/page_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller;
  PageController controller2;
  int currentPageValue = 0;
  int currentPageValue2 = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey();

  Future<KitchensNearResponseModel> allKitchenNear;
  KitchensNearRepository _kitchenNearRepository;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    Map body;

    _kitchenNearRepository = KitchensNearRepository();
    allKitchenNear = _kitchenNearRepository.getAllKitchenNear(body);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            "John Dongler",
                            style: new TextStyle(color: Colors.white, fontSize: 17.0),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Delhi",
                              style: new TextStyle(color: Colors.white, fontSize: 17.0),
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
            Container(
              margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
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
            Container(
              margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
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
            Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0), child: Divider()),
            Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  "About us",
                  style: new TextStyle(color: Colors.grey),
                )),
            Container(
                margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
                child: Text(
                  "Contact us",
                  style: new TextStyle(color: Colors.grey),
                )),
            Container(
                margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
                child: Text(
                  "Concelations and refunds",
                  style: new TextStyle(color: Colors.grey),
                )),
            Container(
                margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
                child: Text(
                  "FAQS",
                  style: new TextStyle(color: Colors.grey),
                )),
            Container(
                margin: EdgeInsets.only(left: 20.0),
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
        children: [
          Container(
            color: Color.fromRGBO(130, 2, 14, 1),
            width: MediaQuery.of(context).size.width,
            height: 50.0,
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
                    style: new TextStyle(color: Colors.white),
                  )),
                  Text(
                    "change",
                    style: new TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/pizza.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    //child: Image.asset("images/poke1.jpg")
                  );
                },
              ),
              length: 4,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Kitchens near you",
                        style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      )),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => KitchensNearYou()),
                            );
                          },
                          child: Text(
                            "see all",
                            style: new TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 180.0,
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  margin: EdgeInsets.only(left: 3.0, right: 3.0),
                  child: new FutureBuilder<KitchensNearResponseModel>(
                    future: allKitchenNear,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KitchenDetailedMenu(
                                            categoryId: snapshot.data.data[index].categoryId,
                                            vendorId: snapshot.data.data[index].vendorId,
                                            vendorName: snapshot.data.data[index].shopName)),
                                  );
                                },
                                child: Container(
                                  width: 150.0,
                                  height: 180.0,
                                  margin: EdgeInsets.only(left: 3.0, right: 3.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 2.0,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 80.0,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://deliveryontime.co.in/api/public" + snapshot.data.data[index].vendorImage),

                                              //AssetImage("images/veg_meal.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          //child: Image.asset("images/poke1.jpg")
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 2.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                snapshot.data.data[index].shopName,
                                                style: new TextStyle(color: Colors.black),
                                              )),
                                              Text(
                                                "4.2",
                                                style: new TextStyle(color: Colors.green),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0, bottom: 3.0),
                                            child: Text(
                                              "veg, Lunch",
                                              style: new TextStyle(color: Colors.grey),
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                            child: Text(
                                              "brakefast, dinner",
                                              style: new TextStyle(color: Colors.grey),
                                            ))
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
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Best Selling Kitchens",
                        style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      )),
                      InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => BestSellingKitchens()),
                            // );
                          },
                          child: Text(
                            "see all",
                            style: new TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 170.0,
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  margin: EdgeInsets.only(left: 3.0, right: 3.0),
                  child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => KitchenDetailedMenu()),
                            // );
                          },
                          child: Container(
                            width: 150.0,
                            height: 180.0,
                            margin: EdgeInsets.only(left: 3.0, right: 3.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 80.0,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage("images/veg_meal.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //child: Image.asset("images/poke1.jpg")
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 2.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "Gopal Kitchen",
                                          style: new TextStyle(color: Colors.black),
                                        )),
                                        Text(
                                          "4.2",
                                          style: new TextStyle(color: Colors.green),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0, bottom: 3.0),
                                      child: Text(
                                        "veg, Lunch",
                                        style: new TextStyle(color: Colors.grey),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                      child: Text(
                                        "brakefast, dinner",
                                        style: new TextStyle(color: Colors.grey),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Order Your Choice",
                        style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                      )),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderYourChoice()),
                            );
                          },
                          child: Text(
                            "see all",
                            style: new TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 160.0,
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  margin: EdgeInsets.only(left: 3.0, right: 3.0),
                  child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Container(
                          width: 140.0,
                          height: 160.0,
                          margin: EdgeInsets.only(left: 3.0, right: 3.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2.0,
                            child: Stack(
                              children: [
                                Container(
                                  height: 160.0,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: AssetImage("images/pizza.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  //child: Image.asset("images/poke1.jpg")
                                ),
                                Positioned(
                                    top: 130.0,
                                    left: 45.0,
                                    child: Text(
                                      "Lunch",
                                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                                    ))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          Container(
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
          ),
        ],
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
  })  : preferredSize = Size.fromHeight(120.0),
        super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState(gkey: gkey);
}

class _HomeAppBarState extends State<HomeAppBar> {
  GlobalKey<ScaffoldState> gkey;

  _HomeAppBarState({this.gkey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: Container(
        height: 160.0,
        color: Color.fromRGBO(143, 23, 35, 1),
        child: Stack(
          children: <Widget>[
            Container(
                color: Color.fromRGBO(143, 23, 35, 1),
                width: MediaQuery.of(context).size.width,
                height: 80.0,
                child: AppBar(
                  backgroundColor: Color.fromRGBO(143, 23, 35, 1),
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  leading: IconButton(
                    onPressed: () {
                      gkey.currentState.openDrawer();
                    },
                    icon: Icon(Icons.menu, color: Colors.white),
                  ),
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
              top: 80.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 55.0,
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
                                    hintText: "Search...",
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
