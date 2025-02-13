import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/Data_Model.dart';

class allData{
  // assets path
  static String animationPath="assets/animation/";
  static String imagePath="assets/images/";

  //Color
  static Color bgColor=Colors.teal;
  static Color fgColor=Colors.white;
  static Color cardBgColor=Colors.teal.shade100;
  static Color themeBgColor=Colors.teal.shade50;

  //Database Data
  // static List<userModel> userList=[];
  // static List<userModel> taskList=[];

  //
  static void toast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: allData.bgColor,
        textColor: allData.fgColor,
        fontSize: 20.0
    );
  }
}