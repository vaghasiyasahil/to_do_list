import 'package:flutter/material.dart';
import 'package:to_do_list/Model/Data_Model.dart';
import 'package:to_do_list/Page/Add_Task.dart';

import '../Services/allData.dart';
import 'Home_Page.dart';

class DetailsPage extends StatefulWidget {
  taskModel data;
  DetailsPage({required this.data,super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: allData.themeBgColor,
            appBar: AppBar(
              backgroundColor: allData.bgColor,
              iconTheme: IconThemeData(
                color: allData.fgColor
              ),
              title: Text(
                widget.data.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize:24,
                  fontWeight: FontWeight.bold
                ),
              ),
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask(data: widget.data,),));
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {
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
                            widget.data.delete();
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
                }, icon: Icon(Icons.delete))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: allData.cardBgColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              "Title",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0,bottom: 8,left: 15),
                          child: Text(
                              widget.data.title,
                            style: TextStyle(
                              fontSize: 19
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: allData.cardBgColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              "Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0,bottom: 8,left: 15),
                          child: Text(
                              widget.data.des,
                            style: TextStyle(
                              fontSize: 19
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: allData.cardBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0,bottom: 8,left: 15),
                          child: Text(
                            "${widget.data.date.split("-")[2]}-${widget.data.date.split("-")[1]}-${widget.data.date.split("-")[0]}",
                            style: TextStyle(
                                fontSize: 19
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: allData.cardBgColor,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0,bottom: 8,left: 15),
                          child: Text(
                            widget.data.time,
                            style: TextStyle(
                                fontSize: 19
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        ));
  }
}
