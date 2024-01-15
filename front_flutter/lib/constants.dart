import 'package:flutter/material.dart';
import 'package:safari_front/model/user.dart';

TextStyle kTitleTextStyle = TextStyle(fontSize: 20, color: kWhite);
TextStyle kSubtitleTextStyle = TextStyle(fontSize: 18, color: kWhite);
TextStyle kContentTextStyle = TextStyle(fontSize: 16, color: kBlack);

Color kWhite = const Color(0xFFFEFEFE);
Color kTransparentBlack = const Color.fromARGB(30, 104, 104, 104);
Color kBlack = const Color(0xFF212121); // grey[900]

Color kLightGrey = const Color.fromARGB(10, 0, 0, 0);

Color kGrey9 = const Color(0xFF303030); // grey[850]
Color kGrey8 = const Color(0xFF424242); // grey[800]
Color kGrey7 = const Color(0xFF616161); // grey[700]
Color kGrey6 = const Color(0xFF757575); // grey[600]
Color kGrey5 = const Color(0xFF9E9E9E); // grey[500]
Color kGrey4 = const Color(0xFFBDBDBD); // grey[400]
Color kGrey3 = const Color(0xFFE0E0E0); // grey[300]
Color kGrey2 = const Color(0xFFEEEEEE); // grey[200]
Color kGrey1 = const Color(0xFFFAFAFA); // grey[50]

Color kOrange = Colors.deepOrangeAccent;
Color kLightOrange = const Color.fromARGB(255, 255, 126, 87);
Color kTransparentOrange = const Color.fromARGB(30, 255, 109, 64);

double kfontSize = 15;

BorderRadius kBorderRadius = BorderRadius.circular(10);

User user = User(name: "", cycle: -1, gender: -1);
