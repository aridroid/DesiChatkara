import 'package:desichatkara/app_screens/FavoriteDelete/FavDeleteBloc.dart';
import 'package:desichatkara/app_screens/FavoriteDelete/FavDeleteModel.dart';
import 'package:desichatkara/app_screens/FavoriteDelete/FavDeleteRepositry.dart';
import 'package:desichatkara/app_screens/favouriteKitchens/favoritekitchensRepo.dart';
import 'package:desichatkara/app_screens/favouriteKitchens/favouriteKitchensModel.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'KitchenDetailedMenu.dart';

class FavoriteKitchens extends StatefulWidget {
  @override
  _FavoriteKitchensState createState() => _FavoriteKitchensState();
}

class _FavoriteKitchensState extends State<FavoriteKitchens> {


  FavoriteDeleteBloc _favoriteDeleteBloc=FavoriteDeleteBloc();
  Future<FavoritekitchensModel> allfavorite;
  Future <FavDeleteModel> allDelete;
  FavoriteKitchenRepository _favoriteKitchenRepository;
  FavoriteDeleteRepository _favoriteDeleteRepository;
  SharedPreferences prefs;
  String userToken;
  String userId;
  bool deleteCheck=false;
  Map idd;

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userToken = prefs.getString("user_token");
    userId=prefs.getString("user_id");
    _favoriteKitchenRepository = FavoriteKitchenRepository();
    allfavorite = _favoriteKitchenRepository.getAllFavourite(userToken);
    //allDelete = _favoriteDeleteRepository.favoritedelete(body, token);

    setState(() {});
  }
  List<Data> listFavorite=[];
  removeDynamic(value) {
    listFavorite.remove(value);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    createSharedPref();

  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
          "Favourite Kitchens",
          style: new TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_on_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            FutureBuilder<FavoritekitchensModel>(
                future: allfavorite,
           builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    if(snapshot.data.data.length>=1){
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              KitchenDetailedMenu(
                                                //categoryId: snapshot.data.data[index].sku.
                                                  vendorId: snapshot.data.data[index].sku.vendorId,
                                                  vendorName: snapshot.data
                                                      .data[index].sku.vendor.shopName)),
                                    );
                                  },
                                  child: Card(
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      margin: EdgeInsets.only(top: 4.0, bottom: 14.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                height: screenWidth * 0.2,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(5.0)),
                                                ),
                                                child: FadeInImage(
                                                  image: NetworkImage(
                                                    imageBaseURL + snapshot.data.data[index].sku.image.productImages,
                                                  ),
                                                  placeholder: AssetImage("images/logo.jpeg"),
                                                  //fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 15.0,
                                                    top: 5.0,
                                                    bottom: 5.0,
                                                    right: 10.0),

                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex:6,
                                                          child: Text(
                                                              snapshot.data.data[index].sku.skuName,
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.black,
                                                                fontSize: screenWidth * 0.04,
                                                              )),
                                                        ),
                                                        Spacer(),
                                                        Expanded(
                                                          flex:1,
                                                          child: StreamBuilder<ApiResponse<FavDeleteModel>>(
                                                              stream: _favoriteDeleteBloc.favoriteDeleteStream,
                                                              builder: (context, snapshot1) {
                                                                //idd=snapshot.data.data[index].id.toString();
                                                                if (snapshot1.hasData) {
                                                                  switch (snapshot1.data.status) {
                                                                    case Status.LOADING:
                                                                      print("Loading");
                                                                      break;
                                                                    case Status.COMPLETED:
                                                                      print("Fav Deleted");
                                                                      Future.delayed(Duration.zero, () {
                                                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteKitchens()));
                                                                          if(deleteCheck){
                                                                            setState(() {
                                                                              allfavorite = _favoriteKitchenRepository.getAllFavourite(userToken);
                                                                            deleteCheck=false;
                                                                            });
                                                                          }

                                                                      });
                                                                      break;
                                                                    case Status.ERROR:
                                                                      print("Fav not deleted");
                                                                      break;
                                                                  }
                                                                }
                                                                return IconButton(
                                                                  icon: Icon(Icons.delete_forever),
                                                                  color:Color.fromRGBO(143, 23, 35, 1),
                                                                  onPressed: () {
                                                                    listFavorite=snapshot.data.data;
                                                                    _favoriteDeleteBloc.favoriteDelete(snapshot.data.data[index].id.toString(),userToken);
                                                                    deleteCheck=true;
                                                                    // setState(() {
                                                                    //
                                                                    // });
                                                                    // removeDynamic(listFavorite[index]);

                                                                  },
                                                                );
                                                              }
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Rs ",
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontWeight: font_semibold,
                                                                    fontSize: screenWidth * 0.032),
                                                              ),
                                                              Text(
                                                                snapshot.data.data[index].sku.price,
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontWeight: font_semibold,
                                                                    fontSize: screenWidth * 0.032),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(left: 18.0),
                                                            // child: Image.asset(
                                                            //   "images/heart2.png",
                                                            //   width: 25.0,
                                                            //   height: 25.0,
                                                            // ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            );
                          },
                        ),
                      );

                    }else{
                      return Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top:250),
                            child: Center(
                              child: Text(
                                "Your Favourite Kitchens is Empty",
                                style: TextStyle(color: lightThemeRed, fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                            ),
                          ),
                        ],
                      );
                    }


                  }
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(child: Text("No data", style: TextStyle(
                        color: Colors.red, fontSize: 20,
                      ),)),
                    );
                  }
                  else {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }


           }
         ),
        ]
      ),
    );
  }
}
