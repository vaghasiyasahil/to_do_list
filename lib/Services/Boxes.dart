import 'package:hive/hive.dart';
import 'package:to_do_list/Model/Data_Model.dart';

class Boxes{
  static Box<userModel> getUserReg() {
    return Hive.box('user');
  }

  static Box<taskModel> getTaskRef(){
    return Hive.box("task");
  }
}