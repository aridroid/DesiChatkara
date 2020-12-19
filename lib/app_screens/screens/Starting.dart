import 'package:desichatkara/app_screens/screens/SignUpLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  List images = ["images/catering.png", "images/payment.png", "images/rasoi_logo.png", "images/advance_logo.png"];
  List title = ["Catering", "Easy Payment", "Best Rasoi", "Advance Search"];
  List d1 = [
    "We cater to all orders over 10 people or more",
    "Make payment using instant and secured online",
    "Select a best fit and appropriate Rasoi which fulfills",
    "Easy to search your favourite kitchen food using"
  ];
  List d2 = [
    "Corporate | Family | Holiday | Parties | More",
    "Process or cash on delivery",
    "your binge and taste buds",
    "advanced location based search filter"
  ];
  PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            child: Container(
              child: Container(
                height: MediaQuery.of(context).size.height * .75,
                width: MediaQuery.of(context).size.width,
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
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 230.0,
                                width: 230.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(162, 34, 47, 0.53),
                                ),
                              ),
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.height * .30,
                                left: 110.0,
                                right: 110.0,
                                child: Image.asset(
                                  images[index],
                                  height: 130.0,
                                  width: 130.0,
                                )),
                            Positioned(
                                top: MediaQuery.of(context).size.height * .60,
                                left: 30.0,
                                right: 30.0,
                                child: Column(
                                  children: [
                                    Text(
                                      title[index],
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 4.0, bottom: 3.0),
                                        child: Text(
                                          d1[index],
                                          style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                                        )),
                                    Text(
                                      d2[index],
                                      style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                  length: 4,
                  align: IndicatorAlign.bottom,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .85,
            left: 40.0,
            right: 40.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
              ),

              // color: Colors.white,
              height: 50.0,
              // padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpLogin(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Continue to Login", style: new TextStyle(color: Colors.black, fontSize: 14.0)),
                    Container(margin: EdgeInsets.only(left: 30.0), child: Icon(Icons.arrow_forward))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
