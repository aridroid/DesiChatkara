import 'package:desichatkara/app_screens/CartPage/Cart.dart';
import 'package:desichatkara/app_screens/orderDetails_screen/OrderHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'UserProfile.dart';

class NavigationButton extends StatefulWidget {
  @override
  _NavigationButtonState createState() => new _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  int _pageIndex = 0;
  PageController _pageController;

  List<Widget> tabPages = [
    Home(),
    OrderHistory(),
    Cart(),
    UserProfile(),

  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Color.fromRGBO(143, 23, 35, 1),
        backgroundColor: Colors.white,

        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            this._pageController.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
            _pageIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(
                AssetImage("images/home.png"),
                 color: Color.fromRGBO(143, 23, 35, 1),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(
                AssetImage("images/orders.png"),
                 color:Color.fromRGBO(143, 23, 35, 1),
              ),
              label: "Orders"),
          BottomNavigationBarItem(
              backgroundColor:Colors.white,
              icon: ImageIcon(
                AssetImage("images/cart.png"),
                 color: Color.fromRGBO(143, 23, 35, 1),
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: ImageIcon(
                AssetImage("images/profileB.png"),
                 color: Color.fromRGBO(143, 23, 35, 1),
              ),
              label: "Profile"),
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index);
  }
}
