import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';

class SearchBarPage extends StatefulWidget {
  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  final searchController = TextEditingController();
  bool isBlank = true;
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
      body: Container(),
    );
  }
}
