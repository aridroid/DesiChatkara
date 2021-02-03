import 'package:desichatkara/app_screens/KitchenByCategory/model/KitchenByCategoryModel.dart';
import 'package:desichatkara/app_screens/KitchenByCategory/repository/KitchenByCategoryRepo.dart';
import 'package:desichatkara/app_screens/screens/KitchenDetailedMenu.dart';
import 'package:desichatkara/app_screens/screens/KitchensNearYou.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KitchenByCategory extends StatefulWidget{
  String categoryid;

  KitchenByCategory(this.categoryid);

  @override
  _KitchenByCategoryState createState() => _KitchenByCategoryState(categoryid);
}

class _KitchenByCategoryState extends State<KitchenByCategory> {
  String categoryid;

  _KitchenByCategoryState(this.categoryid);

  Future<KitchenByCategoryResponseModel> kitchenByCategory;
  KitchenByCategoryRepository _kitchenByCategoryRepository;

  @override
  void initState() {
    super.initState();
    _kitchenByCategoryRepository = KitchenByCategoryRepository();
    kitchenByCategory = _kitchenByCategoryRepository.getKitchenByCategory(categoryid);
  }



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: KitchenAppBar(''),
     body: Padding(
       padding: const EdgeInsets.all(12.0),
       child:
       FutureBuilder<KitchenByCategoryResponseModel>(
         future: kitchenByCategory,
         builder: (context,snapshot){
           if(snapshot.hasData){
             return ListView.builder(
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                 itemCount: snapshot.data.data.length,
                 itemBuilder: (BuildContext ctxt, int index){
                   return  ListView.builder(
                       scrollDirection: Axis.vertical,
                       itemCount: snapshot.data.data[index].vendor.length,
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (BuildContext ctxt, int index1) {
                         return
                           InkWell(
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) => KitchenDetailedMenu(
                                         categoryId: snapshot.data.data[index].categoryId,
                                         vendorId: snapshot.data.data[index].vendor[index1].id,
                                         vendorName: snapshot.data.data[index].vendor[index1].shopName)
                                 ),
                               );
                             },
                             child: Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10.0),
                                 ),
                                 child: Row(
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
                                             bottomRight: Radius.circular(
                                                 10.0)),
                                         // image: DecorationImage(
                                         //   image: //AssetImage("images/veg_meal.png"),
                                         //   snapshot.data.data[index]
                                         //       .productImage == null
                                         //       ? AssetImage(
                                         //       "images/veg_meal.png")
                                         //       : NetworkImage(
                                         //       imageBaseURL+
                                         //           snapshot.data.data[index]
                                         //               .productImage),
                                         //
                                         //   //AssetImage("images/pizza.png"),
                                         //   fit: BoxFit.cover,
                                         // ),
                                       ),
                                       child: FadeInImage(
                                         image: NetworkImage(
                                           imageBaseURL+ snapshot.data.data[index].productImage,
                                         ),
                                         placeholder: AssetImage("images/breakfast.png"),
                                         fit: BoxFit.fill,
                                       ),
                                     ),

                                     Padding(
                                       padding: EdgeInsets.fromLTRB(
                                           10.0, 5.0, 5.0, 5.0),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment
                                             .start,
                                         children: [
                                           Text(
                                             snapshot.data.data[index].productName,
                                             style: new TextStyle(
                                                 color: Colors.black,
                                                 fontSize: 16.0,
                                             fontWeight: font_bold),
                                           ),

                                           Padding(
                                             padding: const EdgeInsets.fromLTRB(
                                                 0.0, 5.0, 0.0, 5.0),
                                             child: Text(
                                             "From  "+snapshot.data.data[index].vendor[index1].shopName,
                                               style: new TextStyle(
                                                   color: Colors.black38,
                                                   fontSize: 14.0),
                                             ),
                                           ),

                                           // Text(
                                           //   snapshot.data.data[index].vendor[index1].address ,
                                           //   style: new TextStyle(
                                           //       color: Colors.black,
                                           //       fontSize: 14.0),
                                           // ),

                                         ],),
                                     )
                                   ]
                                   ,
                                 )
                             )
                             ,
                           );
                       });
                 });
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
           else {
             return Center(child: CircularProgressIndicator());
           }
         },

       )

     ),
   );
  }
}


class KitchenAppBar extends StatefulWidget with PreferredSizeWidget {
  //GlobalKey<ScaffoldState> gkey;

  @override
  final Size preferredSize;

  final String title;

  KitchenAppBar(
      this.title, {
        Key key,
      }
    )  : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  _KitchenAppBarState createState() => _KitchenAppBarState();
}

class _KitchenAppBarState extends State<KitchenAppBar> {
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
              "Kitchens of your choise",
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

        ],
      ),
    );
  }
}
