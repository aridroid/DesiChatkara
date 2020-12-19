
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';


class AddressList extends StatefulWidget{
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
   String _site;
   List radioList=["Delhi road delhi 76",
                     "Delhi road delhi 84",
                     "Delhi road delhi 53"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
            backgroundColor: Color.fromRGBO(143, 23, 35, 1),
            
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
            title: Text("AddressList", style: new TextStyle(color: Colors.white,
                     fontSize: 17.0),),
            
      ),

    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(children: [
         Card(
           
           shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(children: [
                 Icon(Icons.add_outlined,color: Colors.black),
                 Container(
                   margin: EdgeInsets.only(left:10.0),
                   child: Text("Add Address", style: new TextStyle(color: Colors.black,
                           fontSize: 17.0),),
                 ),
                 ],),
           )
          ,),

         new ListView.builder
       (
         physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (BuildContext ctxt, int index) {
       return Container(

         
        
         // margin: EdgeInsets.only(left:3.0,right:3.0),
         child: Card(
           shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
           child:Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
              Theme(

                data: Theme.of(context).copyWith(
    unselectedWidgetColor: Colors.red,
    disabledColor: Colors.white,
    
  ),
                              child: Radio( 
                                activeColor: Colors.red[900], 
                  value: radioList[index].toString(),  
                  groupValue: _site,  
                  onChanged: (String value) {  
                    setState(() {  
                      _site = value;  
                    });  
                  },  
                ),
              ), 
              
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
               Text("Jonh ", style: new TextStyle(color: Colors.black,
                         fontSize: 17.0),),

                Container(
                  margin: EdgeInsets.only(top:10.0),
                  width: 170.0,
                  child: Text("21 B62 / 1 Delhi road juhu lane Noida, delhi 79", style: new TextStyle(color: Colors.black,
                           fontSize: 17.0),),
                ),

                
               ]),

               Card(
                 shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(width: 2, color: Colors.red[900])),
          
                 child:Padding(
                   padding: const EdgeInsets.all(6.0),
                   child: Text("Edit", style: new TextStyle(color: Colors.black,
                           fontSize: 12.0),),
                 ),
               )

             ],),
           ) ,
           
           )
         
       );
      }
  ),


      ],),
    )
       );
  }
}


/*class UserLocationAppBar extends StatefulWidget with PreferredSizeWidget{
     //GlobalKey<ScaffoldState> gkey;
      
      @override
    final Size preferredSize;

    final String title;

    UserLocationAppBar(
        this.title,
        { Key key,}) : preferredSize = Size.fromHeight(150.0),
            super(key: key);

  @override
  _UserLocationAppBarState createState() => _UserLocationAppBarState();
}

class _UserLocationAppBarState extends State<UserLocationAppBar> {
  //GlobalKey<ScaffoldState> gkey;
  //_CartAppBarState({this.gkey});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromRGBO(143, 23, 35, 1),
       body: Column(
         children: [
           AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
            title: Text("AddressList", style: new TextStyle(color: Colors.white,
                     fontSize: 17.0),),
            
      ),

        


     Padding(
       padding: const EdgeInsets.only(top:20.0,bottom:3.0),
       child: Text("Select Your Location", style: new TextStyle(color: Colors.white,
                       fontSize: 17.0),),
     ),


      Text("Please login to enjoy Desichatkara", style: new TextStyle(color: Colors.white,
                     fontSize: 14.0),),

         ],
        ),

     );
   
  }
}*/