import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/Page/Home_Page.dart';
import 'package:to_do_list/Page/Login_Page.dart';
import 'package:to_do_list/Services/preferences.dart';

import '../Services/Boxes.dart';
import '../Services/allData.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      if(await preferences.getUserLoginStatus()){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
    },);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Lottie.asset(
            "${allData.animationPath}SplashScreen.json"
          ),
        ),
      ),
    );
  }

}
