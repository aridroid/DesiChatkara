import 'package:desichatkara/app_screens/address_screens/repository/addressRepository.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addressAddPage.dart';
import 'address_page.dart';
import 'model/addressShowAllModel.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<Data> data;
  String userToken = "";
  Map body;
  String userId = "";
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

  Map _body;

  @override
  void initState() {
    super.initState();
    createSharedPref();
  }

  /*Map body = {"userid": "26"};
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9."
      "eyJhdWQiOiIxIiwianRpIjoiYTJiYzljNWY5Yzgy"
      "NzY1NjI2NDE1Nzc0Y2U4NjVkNmRlNWRmNGNmZGEyYTFhZDh"
      "iN2E0MGFmMWZhMTgzZGM0NjY3ZDA0ZWM1NzcxOTU1ZDkiLCJpY"
      "XQiOjE2MDI5NDk2NDYsIm5iZiI6MTYwMjk0OTY0NiwiZXhwIjoxNj"
      "M0NDg1NjQ2LCJzdWIiOiIyNiIsInNjb3BlcyI6W119.hs1EhLfMfUxM"
      "ACFuLfMP73lPaeDmtvh4xDPpg84jqOJQa7-j9wbrRSLnsXe-FCFsIyyTS"
      "GYJ54lEnCbiLeK3XThpeA-2R7H5jcThHMcCvF8hAg6jr8esAelMyhh10HNvD"
      "dtkZs_Sg6Aa7TtiviQFo6jCQqJPNgsTsr_SRrrcC0WmYE_RnrGb6mBwW4_Lvv8"
      "Ab7F5Yuch6dDLvdEC-_P0jtjdqQZdL7UypSZEN0CqxfG5Z278X-IfpP7_aEOXIZs1"
      "Q1YgKLhvmoZeRefiuAOR3UTp7AReFJOlIwvynOkFPFvzHWKe8mtGekuNV477M7t0q3u"
      "SYwNqmvtZcAib6uSRKXcjGVxEIKh6btCfNvorNrbjjc-QzR6eLx13qdyB99OlUSYs2_xA1"
      "xDM4ARPdzPEeXaxmk1CXZBSaw4jlSVbAc6TloiaGLL_KXxeQmWQIlLgLtdXRM5_DtOcefDTA"
      "hVRHuc7RxFaaqO_N-qjzOadFP80SKdBehap8Bw0NK_xMIy05lSVcU70HGSaiFT4LHbwAlBnK8oK"
      "43D6VcqNDGBopwevi-su0zaeyDaoVkob5bAv4X-3r4pXP7c0d1-AN6DwzNFL4RZAqz2YB7oRn7jmAO"
      "4f1dPqPf7LVK4WBk3OAWpo8_lZBOsplUnFSf4mo-9F4zPFmrRRMmaNGGBaAWZMH98";*/
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
                ),
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
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Radio(
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
                                            ),
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
