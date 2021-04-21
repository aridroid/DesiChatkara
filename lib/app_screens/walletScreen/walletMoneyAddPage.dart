import 'package:desichatkara/app_screens/razorpayWallet/RazorPayWalletScreen.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/walletAddMoneyBloc.dart';
import 'model/walletAddMoneyModel.dart';

class WalletMoneyAddPage extends StatefulWidget {
  final String walletBalance;

  const WalletMoneyAddPage({Key key, this.walletBalance}) : super(key: key);

  @override
  _WalletMoneyAddPageState createState() => _WalletMoneyAddPageState(walletBalance);
}

class _WalletMoneyAddPageState extends State<WalletMoneyAddPage> {
  final String walletBalance;

  _WalletMoneyAddPageState(this.walletBalance);

  TextEditingController _amountController = new TextEditingController(text: "0.0");
  WalletMoneyAddBloc _walletMoneyAddBloc;
  SharedPreferences prefs;
  String userId="";
  String userToken="";


  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId=prefs.getString("user_id");
    userToken=prefs.getString("user_token");

  }

  List<double> amount=[50,100,200,500,1000,2000];


  @override
  void initState() {
    super.initState();
    _walletMoneyAddBloc=new WalletMoneyAddBloc();
    createSharedPref();
  }

  navToAttachList(context,WalletAddMoneyModel data) async {
    Future.delayed(Duration.zero, () {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return RazorPayWalletScreen(snapshotData: data);
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeDeepRed,
        appBar: AppBar(
          backgroundColor: lightThemeRed,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Money",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14),
              ),
              Text(
                "Available Balance:  ₹ $walletBalance",
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,0.0),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,4.0),
                child: Text(
                  "Please Select Amount to Proceed!",
                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 18),
                ),
              ),

              // amount add Text Field.....

              Container(
                height: 45.0,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: _amountController,
                  style: TextStyle(fontSize: 14.0),
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_balance_wallet_outlined,color: darkThemeRed,),
                      hintText: "Enter Amount(₹)",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      border: InputBorder.none),
                ),
              ),

              InkWell(
                onTap: (){
                  _amountController.text="0.0";
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Clear Amount".toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ),
              ),

              Container(
                height: 180,
                margin: EdgeInsets.only(top: 25,bottom: 15),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: amount.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      childAspectRatio: 4/1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 15
                    ),
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          try{
                            if(_amountController.text=="" || _amountController.text==null){
                              _amountController.text=(0.0+amount[index]).toString();
                            }else
                              _amountController.text=(double.parse(_amountController.text)+amount[index]).toString();
                          }catch(ex){
                            print(ex);
                            Fluttertoast.showToast(
                                msg: "Please correct your entered invalid amount",
                                fontSize: 14,
                                backgroundColor: Colors.orange[100],
                                textColor: darkThemeRed,
                                toastLength: Toast.LENGTH_LONG);
                          }

                        },
                        child: Container(
                          height: 30.0,
                          // width: screenWidth * 0.22,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.fromLTRB(4, 0, 7, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Center(
                            child: Text(
                              "+ ₹${amount[index]}",
                              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    }),
              ),

              ButtonTheme(
                /*__To Enlarge Button Size__*/
                height: 50.0,
                minWidth: screenWidth,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    try{
                      if(double.parse(_amountController.text.toString())>=1.0 && (double.parse(_amountController.text.toString())+double.parse(walletBalance))<=10000.0){
                        Map _body={
                          "user_id":"$userId",
                          "amount":"${_amountController.text}",
                          "added_from":"Wallet"
                        };
                        _walletMoneyAddBloc.walletMoneyAdd(_body, userToken);
                      }else if((double.parse(_amountController.text.toString())+double.parse(walletBalance))>10000.0){
                        Fluttertoast.showToast(
                            msg: "You can add maximum Rs.${(10000.0-double.parse(walletBalance)).abs()}",
                            fontSize: 14,
                            backgroundColor: Colors.orange[100],
                            textColor: darkThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                      }else if(double.parse(_amountController.text.toString())>10000.0){
                        Fluttertoast.showToast(
                            msg: "You cannot add more than Rs.10000",
                            fontSize: 14,
                            backgroundColor: Colors.orange[100],
                            textColor: darkThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Please Enter a valid amount",
                            fontSize: 14,
                            backgroundColor: Colors.orange[100],
                            textColor: darkThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                      }
                    }catch(ex){
                      print(ex);
                      Fluttertoast.showToast(
                          msg: "Please Enter a valid amount",
                          fontSize: 14,
                          backgroundColor: Colors.orange[100],
                          textColor: darkThemeRed,
                          toastLength: Toast.LENGTH_LONG);
                    }




                  },
                  color: Colors.orange[200],
                  textColor: darkThemeRed,
                  child: StreamBuilder<ApiResponse<WalletAddMoneyModel>>(
                    stream: _walletMoneyAddBloc.walletMoneyAddStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            return Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: circularBGCol,
                                  strokeWidth: strokeWidth,
                                  valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)),
                            );
                            break;
                          case Status.COMPLETED:
                            print("complete");
                            // managedSharedPref(snapshot.data.data);
                            navToAttachList(context,snapshot.data.data);
                            Fluttertoast.showToast(
                                msg: "You are Redirecting to Payment Gateway",
                                fontSize: 14,
                                backgroundColor: Colors.orange[100],
                                textColor: darkThemeRed,
                                toastLength: Toast.LENGTH_LONG);

                            break;
                          case Status.ERROR:
                            break;
                        }
                      } else if (snapshot.hasError) {
                        Fluttertoast.showToast(
                            msg: "Please Try Again!",
                            fontSize: 14,
                            backgroundColor: Colors.orange[100],
                            textColor: darkThemeRed,
                            toastLength: Toast.LENGTH_LONG);
                        print(snapshot.error);
                      }

                      return Text("Add Money", style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500));
                    },
                  ),



                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
