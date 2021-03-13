import 'dart:math';

import 'package:flutter/material.dart';
const imageBaseURL="http://eqsxerusrangoon.com/desichatkara/api/public";
//const imageBaseURL="https://deliveryontime.co.in/api/public";

const FontWeight font_bold = FontWeight.w700;
const FontWeight font_semibold = FontWeight.w600;

double screenHeight=0;
double screenWidth=0;
bool userLogin;
String changeAddress;
double userLat;
double userLong;
String address;

const darkThemeRed=Color.fromRGBO(130, 2, 14, 1);
const lightThemeRed=Color.fromRGBO(143, 23, 35, 1);
const lightThemeWhite=Color.fromRGBO(243, 243, 243, 1);
const mapApiKey = 'AIzaSyC6hMR5kMX8Y5M0BgxCzZji81nhxf_uLmM';
const circularBGCol=Color.fromRGBO(143, 23, 35, 1);
var circularStrokeCol=Colors.red[50];
const double strokeWidth=4;

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}