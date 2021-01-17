import 'package:desichatkara/app_screens/SearchBarPage/SearchPageBloc/SearchPageBloc.dart';
import 'package:desichatkara/app_screens/SearchBarPage/SearchPageModel/SearchPageModel.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';

import '../../helper/api_response.dart';
import 'SearchFoodVendorPage.dart';
// import 'SearchFoodVendorPage.dart';

class SearchBarPage extends StatefulWidget {
  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  final searchController = TextEditingController();
  bool isBlank = true;
  SearchPageBloc _searchPageBloc;
  String prev = "";
  bool samePrev = false;

  @override
  void initState() {
    super.initState();
    _searchPageBloc = SearchPageBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightThemeRed,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined, color: Colors.white,
          ),
        ),
        title: TextFormField(
          controller: searchController,
          onChanged: (value) {
            if(value.isEmpty){
              setState(() {
                isBlank = true;
              });
            }
            else{
              _searchPageBloc.search({"search_data": value});
              setState(() {
                isBlank = false;
              });
            }

          },
          autofocus: true,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            suffixIcon: isBlank?
              Icon(
                Icons.search,
                  color: Colors.white,
                ) :
              InkWell(
                onTap: () {
                  searchController.clear();
                  setState(() {
                    isBlank = true;
                  });
                },
                child: Icon(
                  Icons.close,
                    color: Colors.white,
                ),
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Search kitchens and dishes",
              hintStyle: new TextStyle(
                  color: Colors.white)
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isBlank ?
          Center(
              child: Text(
                "Type Something to Search",
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              )
          ):
          StreamBuilder<ApiResponse<SearchPageModel>>(
              stream: _searchPageBloc.searchPageStream,
              builder:(context, snapshot) {
              if(snapshot.hasData)
              {
                switch(snapshot.data.status)
                {
                  case Status.LOADING:
                    print("Case 1");
                    print(snapshot);
                    return Center(
                      heightFactor: 5,
                      widthFactor: 10,
                      child: CircularProgressIndicator(
                          backgroundColor: circularBGCol,
                          strokeWidth: strokeWidth,
                          valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)),
                    );
                    break;
                  case Status.COMPLETED:
                    print("Case 2");
                    return ListView.builder(
                        itemCount: snapshot.data.data.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                    return SearchFoodVendorPage(snapshot.data.data.data[index]);
                                  }));
                                },
                                child: ListTile(
                                    leading: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      ),
                                      child: FadeInImage(
                                        height: 55,
                                        width: 55,
                                        image: NetworkImage(
                                          "$imageBaseURL${snapshot.data.data.data[index].productImage}",
                                        ),
                                        placeholder: AssetImage("images/breakfast.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    title: Text(snapshot.data.data.data[index].productName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )),
                              ),
                              Divider(
                                color: Colors.orange,
                                // thickness: 1,
                              )
                            ],
                          );
                        });
                    break;
                  case Status.ERROR:
                    print("Case 3");
                    return Center(
                      child: Text("No Result Found", style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey
                      )),
                    );
                    break;
                }
              }

              return Container();

            },
      )
    );
  }
}
