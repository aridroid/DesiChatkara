import 'dart:io';
import 'package:desichatkara/app_screens/screens/NavigationButton.dart';
import 'package:desichatkara/constants.dart';
import 'package:desichatkara/helper/api_base_helper.dart';
import 'package:desichatkara/helper/api_response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';

import 'CameraScreen.dart';
import 'bloc/profileUpdateBloc.dart';
import 'model/profileUpdateModel.dart';

class ProfileManagePage extends StatefulWidget {
  final String imgPath;

  ProfileManagePage({this.imgPath});

  @override
  _ProfileManagePageState createState() => _ProfileManagePageState();
}

class _ProfileManagePageState extends State<ProfileManagePage> {


  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _phoneController;
  SharedPreferences prefs;
  String name="";
  String email="";
  String userId="";
  String userToken="";
  String userPhone="";
  String userPhoto="";


  File imageFile1;//change from File to string
  final Dio _dio = Dio();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProfileUpdateBloc _profileUpdateBloc;
  bool updateCheck=false;


  void initState() {
    super.initState();
    // if(widget.imgPath!=null){
    //   userPhoto=widget.imgPath;
    // }
    _profileUpdateBloc=new ProfileUpdateBloc();
    createSharedPref();

  }

  Future<void> createSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    userId=prefs.getString("user_id");
    name=prefs.getString("name");
    email=prefs.getString("email");
    userToken=prefs.getString("user_token");
    userPhone=prefs.getString("user_phone");
    userPhoto=prefs.getString("user_photo");
    print(prefs.getString("name"));
    _nameController=new TextEditingController(text: "$name");
    _emailController=new TextEditingController(text: "$email");
    _phoneController=new TextEditingController(text: "$userPhone");
    setState(() {});
  }

  navToAttachList(context) async {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return NavigationButton(currentIndex: 3,);
     }));
    });
  }

  Future<void> managedSharedPref(ProfileUpdateModel data) async {
    prefs.setString("name", "${data.data.name}");
    prefs.setString("email", "${data.data.email}");
    prefs.setString("user_phone", "${data.data.mobileNumber}");
    prefs.setString("user_photo", "${data.data.profilePic}");

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              // height: screenHeight * 0.26,
              child: Column(
                children: [
                  //Upper Container with Address and icons....
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0,20),
                    child: Text(
                      "Edit PROFILE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20,bottom: 20),
                        padding: EdgeInsets.all(3),
                        height: 92,
                        width: 92,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: _buildImage1(),
                      ),
                      InkWell(
                        onTap: (){
                          _showSelectionDialog1(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 70, left: 75),
                          height: 31,
                          width: 31,
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.add_a_photo,
                            color:darkThemeRed,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                ],
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: lightThemeRed,
               // borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              // child: child,
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.fromLTRB(12, 10, 12 ,10),
              // padding: EdgeInsets.all(10.0),
              color: Colors.white,
             // elevation: 5,
             //  shape: RoundedRectangleBorder(
             //      borderRadius: BorderRadius.circular(12.0)),
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Theme(
                        data: new ThemeData(
                          primaryColor: darkThemeRed,
                          primaryColorDark: Colors.black,
                        ),
                        child: TextFormField(
                          validator: (value)=> value.isEmpty?"*Name Required":null,
                          controller: _nameController,
                          decoration: new InputDecoration(
                            suffixIcon: Icon(Icons.edit_outlined,
                            size: 18,
                            color: darkThemeRed,),
                              labelText: "Full Name",
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400
                              ),
                              fillColor: Colors.white,
                              focusColor: darkThemeRed,
                              hoverColor: darkThemeRed,
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.poppins(
                              fontSize: 13.0,
                              color: darkThemeRed,
                              height: 1,
                              fontWeight: FontWeight.w500
                          ),),
                      ),

                      SizedBox(height: 12,),

                      Theme(
                        data: new ThemeData(
                          primaryColor: darkThemeRed,
                          primaryColorDark: Colors.black,
                        ),
                        child: TextFormField(
                          validator: (value)=> value.isEmpty?"*Email ID Required":null,
                          controller: _emailController,
                          decoration: new InputDecoration(
                              suffixIcon: Icon(Icons.edit_outlined,
                                size: 18,
                                color: darkThemeRed,),
                              labelText: "Email ID",
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400
                              ),
                              fillColor: Colors.white,
                              focusColor:darkThemeRed,
                              hoverColor:darkThemeRed,
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.poppins(
                              fontSize: 13.0,
                              color:darkThemeRed,
                              height: 1,
                              fontWeight: FontWeight.w500
                          ),),
                      ),

                      SizedBox(height: 12,),

                      Theme(
                        data: new ThemeData(
                          primaryColor:darkThemeRed,
                          primaryColorDark: Colors.black,
                        ),
                        child: TextField(
                          controller: _phoneController,
                          readOnly: true,
                          decoration: new InputDecoration(
                              labelText: "Mobile No.",
                              labelStyle: GoogleFonts.poppins(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400
                              ),
                              fillColor: Colors.white,
                              // focusColor: orangeCol,
                              // hoverColor: orangeCol
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.poppins(
                              fontSize: 13.0,
                              color: darkThemeRed,
                              height: 0.8,
                              fontWeight: FontWeight.w500
                          ),),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12 ,10),
              child: InkWell(
                onTap: (){
                  final FormState form = _formKey.currentState;
                  if (form.validate()) {
                    print('Form is valid');
                    Map body;
                    if(email!=_emailController.text.trim()){
                      body={
                        "name":"${_nameController.text.trim()}",
                        "email":"${_emailController.text.trim()}",
                        "user_id":"$userId"
                      };
                      updateCheck=true;
                      _profileUpdateBloc.profileUpdate(body, imageFile1, userToken);
                    }else{
                      body={
                        "name":"${_nameController.text.trim()}",
                        "user_id":"$userId"
                      };
                      updateCheck=true;
                      _profileUpdateBloc.profileUpdate(body, imageFile1, userToken);
                    }
                  } else {
                    print('Form is invalid');
                    Fluttertoast.showToast(
                        msg: "Please fill required fields",
                        fontSize: 16,
                        backgroundColor: Colors.orange[100],
                        textColor: Colors.blue,
                        toastLength: Toast.LENGTH_LONG);
                  }
                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      boxShadow: <BoxShadow>[
                        // BoxShadow(
                        //     color:darkThemeRed,
                        //     // offset: Offset(2, 4),
                        //     blurRadius: 5,
                        //     spreadRadius: 2)
                      ],
                      gradient: LinearGradient(
                         begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [darkThemeRed, darkThemeRed])
                  ),
                   child:
                   StreamBuilder<ApiResponse<ProfileUpdateModel>>(
                    stream: _profileUpdateBloc.profileUpdateStream,
                    builder: (context, snapshot) {
                      if(updateCheck){
                        if (snapshot.hasData) {
                          switch (snapshot.data.status) {
                            case Status.LOADING:
                              return CircularProgressIndicator(
                                  backgroundColor: circularBGCol,
                                  strokeWidth: strokeWidth,
                                  valueColor: AlwaysStoppedAnimation<Color>(circularStrokeCol)
                              );
                              /*Loading(
                              loadingMessage: snapshot.data.message,
                            );*/
                              break;
                            case Status.COMPLETED:
                              if (snapshot.data.data.message == "Profile updated successfully")
                              {
                                print("complete");
                                updateCheck=false;
                                managedSharedPref(snapshot.data.data);
                                navToAttachList(context);
                                Fluttertoast.showToast(
                                    msg: "Profile Updated",
                                    fontSize: 16,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG);
                              }else{
                                Fluttertoast.showToast(
                                    msg: "${snapshot.data.data.message}",
                                    fontSize: 16,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.blue,
                                    toastLength: Toast.LENGTH_LONG);
                              }
                              break;
                            case Status.ERROR:
                              print(snapshot.error);
                              updateCheck=false;
                              Fluttertoast.showToast(
                                  msg: "Please try again!",
                                  fontSize: 16,
                                  backgroundColor: Colors.orange[100],
                                  textColor: Colors.blue,
                                  toastLength: Toast.LENGTH_LONG);
                              //   Error(
                              //   errorMessage: snapshot.data.message,
                              // );
                              break;
                          }
                        }
                        else if (snapshot.hasError) {
                          updateCheck=false;
                          print(snapshot.error);
                          Fluttertoast.showToast(
                              msg: "Please try again!",
                              fontSize: 16,
                              backgroundColor: Colors.orange[100],
                              textColor: darkThemeRed,
                              toastLength: Toast.LENGTH_LONG);
                        }
                      }
                      return Text(
                        'Save Changes',
                        style:TextStyle(fontSize: 17,fontWeight: FontWeight.w600, color: Colors.white,),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSelectionDialog1(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery1(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => CameraScreen(),
                        //     ));
                        _openCamera1(context);

                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery1(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 30);
    this.setState(() {
      if (imageFile1 == null)
        print("img null");
      else
        print("img not null");
      imageFile1 = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera1(BuildContext context) async {
    // ignore: deprecated_member_use
   // var picture = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 30);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(),
        ));
    this.setState(() {
      imageFile1 = File(widget.imgPath);//(convert String to File)
    });
    Navigator.of(context).pop();
  }

  _buildImage1() {
   // imageFile1=File(widget.imgPath);
    if (imageFile1 != null) {
      // uploadFile1(imageFile1);
      return Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
              child: Image.file(
                imageFile1,
                fit: BoxFit.cover,
              )));
    } else {
      return Container(
          height: 90,
          width: 90,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              shape: BoxShape.circle),
          child: FadeInImage(
        height: 180.0,
        width: 130.0,
        image: NetworkImage(
          //"$imageBaseURL$userPhoto",
          "$imageBaseURL${(userPhoto!= "") ? userPhoto : "null"}",
        ),
        placeholder: AssetImage("images/profile.png"),
        fit: BoxFit.fill,
      ),
        // child: Image.asset("asset/blank-profile-picture-973460_1280.webp")
      );
    }
  }

  // uploadFile1(File imageFile1) async {
  //   print(imageFile1.path);
  //   var filenames = await MultipartFile.fromFile(File(imageFile1.path).path,
  //       filename: imageFile1.path);
  //
  //   FormData formData =
  //   FormData.fromMap({"filenames[]": filenames, "type": "category"});
  //
  //   print(formData);
  //
  //   Response res = await _dio.post(ApiBaseHelper.baseUrl + "upload/image",
  //       data: formData,
  //       options: Options(headers: {"Authorization": "Bearer " + userToken}));
  //
  //   print(res.data);
  //   print(res.runtimeType);
  //   print(res.data['data']);
  // }


}
