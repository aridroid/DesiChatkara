import 'package:desichatkara/app_screens/SearchBarPage/SearchPageBloc/SearchPageBloc.dart';
import 'package:desichatkara/app_screens/SearchBarPage/SearchPageModel/SearchPageModel.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';

import '../../helper/api_response.dart';

class SearchBarPage extends StatefulWidget {
  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  final searchController = TextEditingController();
  bool isBlank = true;
  SearchPageBloc _searchPageBloc;

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
              isBlank = true;
            }
            else{
              isBlank = false;
            }
            setState(() {

            });
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

                    break;
                  case Status.ERROR:
                    print("Case 3");

                    return Center(
                      child: Text("Error", style: TextStyle(
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
