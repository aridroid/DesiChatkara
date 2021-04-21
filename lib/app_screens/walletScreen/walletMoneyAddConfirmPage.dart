import 'package:desichatkara/app_screens/screens/NavigationButton.dart';
import 'package:desichatkara/app_screens/walletScreen/walletPage.dart';
import 'package:desichatkara/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class WalletMoneyAddConfirmPage extends StatefulWidget {
  @override
  _WalletMoneyAddConfirmPageState createState() => _WalletMoneyAddConfirmPageState();
}

class _WalletMoneyAddConfirmPageState extends State<WalletMoneyAddConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: darkThemeRed,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,70),
                      child: Image.asset(
                        "images/plus.png",
                        width: screenWidth * 0.4,
                        height: screenWidth * 0.4,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Wallet Reload Successful!",
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: screenWidth * 0.055,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Thank you",
                        style: GoogleFonts.poppins(color: Colors.orange[100], fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Amount will be reflected in your wallet\nsoon",
                        // "We have received your payment.",
                        style: GoogleFonts.poppins(color: Colors.orange, fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                    child: ButtonTheme(   /*__To Enlarge Button Size__*/
                      height: 50.0,
                      minWidth: screenWidth,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return WalletPage();
                              }));
                        },
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text("Wallet Details",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange,
                            width: 2),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: ButtonTheme(   /*__To Enlarge Button Size__*/
                      height: 50.0,
                      minWidth: screenWidth,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                                return NavigationButton();
                              }));
                        },
                        color: Colors.white,
                        textColor: Colors.orange,
                        child: Text("Back to Home",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500
                            )),
                      ),
                    ),
                  ),


                ],
              ),
            )));
  }
}
