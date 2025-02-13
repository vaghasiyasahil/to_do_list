import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/Model/Data_Model.dart';
import 'package:to_do_list/Page/Home_Page.dart';
import 'package:to_do_list/Page/Login_Page.dart';
import 'package:to_do_list/Page/Splash_Screen_Page.dart';
import 'package:to_do_list/Services/preferences.dart';

import 'Services/Boxes.dart';
import 'Services/allData.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  preferences.iniMemory();

  await Hive.initFlutter();

  Hive.registerAdapter(userModelAdapter());
  Hive.registerAdapter(taskModelAdapter());

  Hive.openBox<userModel>("user");
  Hive.openBox<taskModel>("task");

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    )
  );
}
