import 'package:desichatkara/app_screens/address_screens/repository/addressRepository.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addressAddPage.dart';
import 'address_page.dart';
import 'model/addressShowAllModel.dart';

class AddressListPage extends StatefulWidget {
  final String latitude;
  final String longitude;

  const AddressListPage({Key key, this.latitude, this.longitude}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<Data> data;
  String userToken = "";
  Map body;
  String userId = "";
 // List<double> shopDistance=new List<double>();

  double shopDistance;

  Future<AddressShowAllModel> _addressApi;

  Future<void> createSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("address page");
    print(prefs.getString("user_token"));
    userId = prefs.getString("user_id");
    userToken = prefs.getString("user_token");
    body = {"userid": "$userId"};
    _addressApi = _addressRepository.addressShowAll(body, userToken);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  AddressRepository _addressRepository = new AddressRepository();
  List val = [10, 20, 30, 40, 50];
  String _addressId="";
  String _address="";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: lightThemeRed,
          onPressed: () {
            double totalDistance = calculateDistance2(
                userLat,
                userLong,
                (widget.latitude != null)
                    ? double.parse(widget.latitude)
                    : userLat,
                (widget.longitude != null)
                    ? double.parse(widget.longitude)
                    : userLong);
            shopDistance=totalDistance;

            if (shopDistance <= 10.0) {
              if(_addressId!=""){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddressPage(addressId: _addressId,)));
              }
              else{
                Fluttertoast.showToast(
                    msg: "Please Select a Address",
                    fontSize: 16,
                    backgroundColor: Colors.white,
                    textColor: darkThemeRed,
                    toastLength: Toast.LENGTH_LONG);
              }
            } else {
              Fluttertoast.showToast(
                  msg: "This shop is Undeliverable at your location",
                  fontSize: 14,
                  backgroundColor: Colors.orange[100],
                  textColor: darkThemeRed,
                  toastLength: Toast.LENGTH_LONG);
            }


          },
          label: Container(
            height: 35.0,
            child: Center(
              child: Text(
                " Proceed to Checkout...",
                style:
                TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
              ),
            ),
          ),
        ),
        appBar: AppBar(
            backgroundColor: lightThemeRed,
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
            title: Center(
                child: Text(
              "Select Address".toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04),
            )),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ), onPressed: () {  },
              ),
            ]),
        backgroundColor: lightThemeWhite,
        body: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressAddPage()));
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.add,
                        color: darkThemeRed,
                        size: 25.0,
                      ),
                    ),
                    Expanded(
                        flex: 9,
                        child: Text(
                          " Add New Address",
                          style: TextStyle(
                              color: darkThemeRed,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
            FutureBuilder<AddressShowAllModel>(
                future: _addressApi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    data=snapshot.data.data;
                    return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                            margin: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                            // height: 160,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.black,
                                disabledColor: Colors.red,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child:Radio(
                                          activeColor: darkThemeRed,
                                          value: snapshot.data.data[index].id,
                                          groupValue: _addressId,
                                          onChanged: (value) {
                                            setState(() {
                                              _addressId = value;
                                              // _address="${snapshot.data.data[value].address}, ${snapshot.data.data[value].landmark}, ${snapshot.data.data[value].city}, ${snapshot.data.data[value].state}, ${snapshot.data.data[value].zip}";
                                              print(_address);
                                            });
                                          },
                                        ),

                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0.0, 8.0, 0.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data.data[index].addressName}",
                                                style: TextStyle(
                                                    color: darkThemeRed,
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600),
                                              ),

                                              /*Text("${snapshot.data.data[index].landmark}"),
                                            Text("${snapshot.data.data[index].city}"),
                                            Text("${snapshot.data.data[index].state}"),
                                            Text("${snapshot.data.data[index].zip}"),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 32.0,
                                            // width: 10.0,
                                            padding: EdgeInsets.only(right: 2,bottom: 2),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: lightThemeRed, width: 1.3,style: BorderStyle.solid),
                                              borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                              color: Colors.white,
                                            ),
                                            child: IconButton(
                                              icon: Icon(Icons.edit_outlined,
                                                color: lightThemeRed,
                                                size: 17,
                                              ), onPressed: () {  },
                                            ),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2.0, 0.0, 8.0, 5.0),
                                          child: Text(
                                            "${snapshot.data.data[index].address}, ${snapshot.data.data[index].landmark}, ${snapshot.data.data[index].city}, ${snapshot.data.data[index].state}, ${snapshot.data.data[index].zip}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
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
                }),
          ],
        ),
      ),
    );
  }
}
