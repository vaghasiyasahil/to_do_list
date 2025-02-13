
import 'package:hive/hive.dart';
part 'Data_Model.g.dart';

@HiveType(typeId: 0)
class userModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;

  userModel(this.name, this.email, this.password);

}

@HiveType(typeId: 1)
class taskModel extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  String des;
  @HiveField(2)
  String date;
  @HiveField(3)
  String time;
  @HiveField(4)
  String uEmail;
  @HiveField(5)
  bool isCmp;

  taskModel(this.title, this.des, this.date, this.time, this.uEmail,this.isCmp);
}