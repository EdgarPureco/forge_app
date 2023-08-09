import 'package:flutter/material.dart';
import 'package:forge_app/style/appStyle.dart';

class GlobalData {

  static var textBlack40 = appStyle(40, Colors.black, FontWeight.bold);
  static var textBlack30 = appStyle(30, Colors.black, FontWeight.w600);
  static var textBlack24 = appStyle(24, Colors.black, FontWeight.bold);
  static var textBlack22 = appStyle(22, Colors.black, FontWeight.bold);
  static var textBlack20 = appStyle(20, Colors.black, FontWeight.bold);
  static var textBlack18Ht = appStyleHeight(18, Colors.black, FontWeight.bold, 0.8 );
  static var textBlack16Ht = appStyleHeight(16, Colors.black, FontWeight.bold, 0.6 );

  static var textGrey18 = appStyleHeight(18, Colors.grey, FontWeight.bold, 1.5 );

  static var textWhite24 = appStyle(24, Colors.white, FontWeight.bold);
  static var textWhite42Ht = appStyleHeight(42, Colors.white, FontWeight.bold, 1.5 );
  static var textWhite36Ht = appStyleHeight(36, Colors.white, FontWeight.bold, 1.1 );
}