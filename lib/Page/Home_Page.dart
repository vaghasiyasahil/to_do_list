import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/Model/Data_Model.dart';
import 'package:to_do_list/Page/Add_Task.dart';
import 'package:to_do_list/Page/Details_Page.dart';
import 'package:to_do_list/Page/Login_Page.dart';
import 'package:to_do_list/Services/Boxes.dart';
import 'package:to_do_list/Services/preferences.dart';

import '../Services/allData.dart';

class HomePage extends StatefulWidget {
  String? showDate;
  HomePage({this.showDate,super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDate();
  }

  List<taskModel> taskList=[];
  List dateList=[];
  String loginuser="";
  String todayDate="";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          SystemNavigator.pop();
        },
        child: SafeArea(
            child: Scaffold(
              drawer: Drawer(
                width: 200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: Column(
                  children: [
                    Container(
                      color: allData.bgColor,
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "To Do List",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: allData.fgColor,
                            fontSize: 25
                        ),
                      ),
                    ),
                    Expanded(
                      child: dateList.isNotEmpty?
                        ListView.builder(itemCount: dateList.length,itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(showDate: dateList[index]),));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${dateList[index]}",
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                ),
                                Icon(CupertinoIcons.right_chevron)
                              ],
                            ),
                          ),
                        );
                      },):
                          Center(
                            child: Text("No Task",style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: allData.bgColor
                            ),),
                          ),
                    )
                  ],
                ),
              ),
              appBar: AppBar(
                // automaticallyImplyLeading: false,
                backgroundColor: allData.bgColor,
                iconTheme: IconThemeData(
                    color: allData.fgColor
                ),
                title: Text(
                  "${todayDate==widget.showDate?"Today":"${widget.showDate}"}",
                  style: TextStyle(
                      color: allData.fgColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                actions: [
                  IconButton(onPressed: () {
                    preferences.setUserLoginStatus(false);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  }, icon: Icon(Icons.logout))
                ],
              ),
              body: ValueListenableBuilder<Box<taskModel>>(
                valueListenable: Boxes.getTaskRef().listenable(),
                builder: (BuildContext context, box, Widget? child) {
                  taskList=box.values.where((element) => element.date==widget.showDate && element.uEmail==loginuser,).toList();
                  print("start");
                  return taskList.isNotEmpty?
                    ListView.builder(itemCount: taskList.length,itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: allData.bgColor,
                        child: Icon(Icons.delete,color: Colors.white,),
                      ),
                      key: Key("todo"),
                      confirmDismiss: (direction) {
                        return showDialog(barrierDismissible: false,context: context, builder: (context) {
                          return AlertDialog(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.zero
                            ),
                            title: Center(child: Text("Delete Contact")),
                            titleTextStyle: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            ),
                            content: Text("Are you sure you want to delete this number?",textAlign: TextAlign.center,),
                            contentTextStyle: TextStyle(
                                fontSize: 22,
                                color: Colors.black
                            ),
                            actions: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text("Cancel",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white
                                    ),),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  taskList[index].delete();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                  child: Text("Delete",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white
                                    ),),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },);
                      },
                      child: Card(
                        color: allData.cardBgColor,
                        elevation: 5,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(data: taskList[index],),));
                          },
                          onLongPress: () {
                            showDialog(barrierDismissible: false,context: context, builder: (context) {
                              return AlertDialog(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero
                                ),
                                title: Center(child: Text("Delete Contact")),
                                titleTextStyle: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                ),
                                content: Text("Are you sure you want to delete this number?",textAlign: TextAlign.center,),
                                contentTextStyle: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text("Cancel",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white
                                        ),),
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      taskList[index].delete();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                      child: Text("Delete",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white
                                        ),),
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },);
                          },
                          title: Text(taskList[index].title,maxLines: 1,),
                          subtitle: Text(taskList[index].des,maxLines: 1,),
                          trailing: Switch(
                            activeColor: Colors.teal,
                            value: taskList[index].isCmp, onChanged: (value) {
                            taskList[index].isCmp=value;
                            taskList[index].save();
                            setState(() {});
                          },),
                        ),
                      ),
                    );
                  },):
                    Center(
                      child: Text(
                        "No Task",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: allData.bgColor
                        ),
                      ),
                    );
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask(),));
                },child: Icon(Icons.add,color: Colors.white,),),
            )
        )
    );
  }

  Future<void> getDate() async {
    var day=DateTime.now().day.toString().length==1?"0${DateTime.now().day}":DateTime.now().day;
    var month=DateTime.now().month.toString().length==1?"0${DateTime.now().month}":DateTime.now().month;
    var year=DateTime.now().year.toString().length==1?"0${DateTime.now().year}":DateTime.now().year;
    if(widget.showDate==null){
      widget.showDate="$day-$month-$year";
    }
    todayDate="$day-$month-$year";
    var ref=Boxes.getTaskRef();
    loginuser=await preferences.getUserEmail();
    List<taskModel> tempData=ref.values.toList();
    for(int i=0;i<tempData.length;i++){
      if(tempData[i].uEmail==await preferences.getUserEmail()){
        if(!dateList.contains(tempData[i].date)){
          dateList.add(tempData[i].date);
        }
      }
    }
    print(dateList);
    dateList.sort((a, b) {
      print(a);
      print(b);
      List<String> dateA = a.split('-');
      List<String> dateB = b.split('-');

      int dayA = int.parse(dateA[0]);
      int monthA = int.parse(dateA[1]);
      int yearA = int.parse(dateA[2]);

      int dayB = int.parse(dateB[0]);
      int monthB = int.parse(dateB[1]);
      int yearB = int.parse(dateB[2]);

      if (yearA != yearB) {
        return yearA.compareTo(yearB);
      } else if (monthA != monthB) {
        return monthA.compareTo(monthB);
      } else {
        return dayA.compareTo(dayB);
      }
    },);
    print(dateList);
    setState(() {});
  }
}