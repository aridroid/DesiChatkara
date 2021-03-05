import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:desichatkara/utility/Error.dart';
import 'package:desichatkara/utility/Loading.dart';

import 'addressListPage.dart';
import 'bloc/addressAddBloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'model/addressAddModel.dart';

class AddressAddPage extends StatefulWidget {
  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  TextEditingController _nameAddress = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _landmark = new TextEditingController();
  TextEditingController _city = new TextEditingController();
  TextEditingController _state = new TextEditingController();
  TextEditingController _zip = new TextEditingController();

  AddressAddBloc _addressAddBloc;

  String userName = "";
  String userId = "";
  String userToken = "";

  @override
  void initState() {
    super.initState();
    createSharedPref();
    _addressAddBloc = new AddressAddBloc();
  }

  Future<void> createSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("name");
    userId = prefs.getString("user_id");
    userToken = prefs.getString("user_token");
    print(userToken);
    print(prefs.getString("user_token"));
  }

  navToAttachList(context) async {
    Future.delayed(Duration.zero, () {
      print("push");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return AddressListPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: lightThemeRed,
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
              "Add Address".toUpperCase(),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
            )),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ]),
        backgroundColor: lightThemeWhite,
        body: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            // Address Text.....

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Add New Address",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: lightThemeRed,
                        fontSize: 17,
                        fontWeight: font_bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                        _getLocation();
                        // _startingPointText.text = _address;
                        // setState(() {
                        //
                        // });
                      },
                      icon: Icon(Icons.my_location, color: lightThemeRed, size: screenWidth * 0.07),
                    ),
                  )
                ],
              ),
            ),

            StreamBuilder<ApiResponse<AddressAddModel>>(
              stream: _addressAddBloc.addressAddStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(
                        loadingMessage: snapshot.data.message,
                      );
                      break;
                    case Status.COMPLETED:
                      print("complete");
                      // managedSharedPref(snapshot.data.data);
                      navToAttachList(context);
                      Fluttertoast.showToast(
                          msg: "Address Added Successfully",
                          fontSize: 14,
                          backgroundColor: Colors.white,
                          textColor: darkThemeRed,
                          toastLength: Toast.LENGTH_LONG);

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

            // Full Name Text Field.....

            Container(
              height: 48.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 25, 15, 10),
              padding: EdgeInsets.only(left: 10,top: 1.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: lightThemeRed)
              ),
              child: TextField(
                controller: _nameAddress,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.person,
                    color: lightThemeRed,),
                    hintText: "Full Name of Address",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),
              ),
            ),

            // Email Text Field.....

            Container(
              height: 48.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 8, 15, 10),
              padding: EdgeInsets.only(left: 10,top: 1.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: lightThemeRed)
              ),
              child: TextField(
                controller: _address,
                keyboardType: TextInputType.streetAddress,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.add_business_rounded,
                      color: lightThemeRed,),
                    hintText: "Full Address",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),

              ),
            ),

            // Email Text Field.....

            Container(
              height: 48.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 8, 15, 10),
              padding: EdgeInsets.only(left: 10,top: 1.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: lightThemeRed)
              ),
              child: TextField(
                controller: _landmark,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.home_work_outlined,
                      color: lightThemeRed,),
                    hintText: "Nearest Landmark",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),

              ),
            ),

            // Email Text Field.....

            Container(
              height: 48.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 8, 15, 10),
              padding: EdgeInsets.only(left: 10,top: 1.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: lightThemeRed)
              ),
              child: TextField(
                controller: _city,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.location_city_sharp,
                      color: lightThemeRed,),
                    hintText: "City",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),

              ),
            ),

            // Email Text Field.....

            Container(
              height: 48.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 8, 15, 10),
              padding: EdgeInsets.only(left: 10,top: 1.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: lightThemeRed)
              ),
              child: TextField(
                controller: _state,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.landscape_outlined,
                      color: lightThemeRed,),
                    hintText: "State",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),

              ),
            ),

            // Email Text Field.....

            Container(
              height: 48.0,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(15, 8, 15, 35),
              padding: EdgeInsets.only(left: 10,top: 1.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: lightThemeRed)
              ),
              child: TextField(
                controller: _zip,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14.0),
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.pin_drop_outlined,
                      color: lightThemeRed,),
                    hintText: "PIN Code",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none),

              ),
            ),

            //Sign Up Button.....

            Container(
              color: lightThemeRed,
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              child: ButtonTheme(
                /*__To Enlarge Button Size__*/
                height: 45.0,

                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    if (_address.text.trim() == "" ||
                        _city.text.trim() == "" ||
                        _state.text.trim() == "" ||
                        _zip.text.trim() == "" ||
                        _landmark.text.trim() == "" ||
                        _nameAddress.text.trim() == "") {
                      Fluttertoast.showToast(
                          msg: "Please Fill all Required Field",
                          fontSize: 14,
                          backgroundColor: Colors.white,
                          textColor: darkThemeRed,
                          toastLength: Toast.LENGTH_LONG);
                    } else if (100000 >= int.parse(_zip.text.trim()) || int.parse(_zip.text.trim()) >= 949999) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              // title: Text("Give the code?"),
                              content: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Currently We are not Serving at Your Given PIN Code Location",
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
                                      "Ok, I Understand",
                                      style: TextStyle(
                                        color: Colors.deepOrangeAccent,
                                        fontSize: 14.0,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _zip.text = "";
                                      });
                                    }),
                              ],
                            );
                          });
                    } else {
                      Map body = {
                        "address": "${_address.text.trim()}",
                        "city": "${_city.text.trim()}",
                        "state": "${_state.text.trim()}",
                        "zip": "${_zip.text.trim()}",
                        "landmark": "${_landmark.text.trim()}",
                        "userid": "$userId",
                        "address_name": "${_nameAddress.text.trim()}"
                      };

                      _addressAddBloc.addressAdd(body, userToken);
                    }

                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                          // HomePage()
                          // AddressPage()
                        ));*/
                  },
                  color: lightThemeWhite,
                  textColor: Colors.black,
                  child: Text("Save Address", style: TextStyle(fontSize: 16,)),
                ),
              ),
            ),

            // New Sign up Text.....

            SizedBox(
              height: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    _nameAddress.text = userName;
    _address.text = first.addressLine;
    _landmark.text = "";
    _city.text = first.subAdminArea;
    _state.text = first.adminArea;
    _zip.text = first.postalCode;
    /*print(first.addressLine);
    print(first.adminArea);
    print(first.locality);
    print(first.subLocality);
    print(first.adminArea);
    print(first.subAdminArea);
    print(first.featureName);
    print(first.subThoroughfare);
    print(first.thoroughfare);
    print(first.postalCode);*/

    /*_.text = "${first.addressLine}";
    print("${first.featureName} : ${first.addressLine}");*/
    setState(() {});
  }
}
