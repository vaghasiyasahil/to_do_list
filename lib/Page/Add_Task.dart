import 'package:flutter/material.dart';
import 'package:to_do_list/Model/Data_Model.dart';
import 'package:to_do_list/Page/Details_Page.dart';
import 'package:to_do_list/Page/Home_Page.dart';
import 'package:to_do_list/Services/preferences.dart';

import '../Services/Boxes.dart';
import '../Services/allData.dart';

class AddTask extends StatefulWidget {
  taskModel? data;
  AddTask({this.data,super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  TextEditingController title=TextEditingController();
  TextEditingController des=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController time=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if(widget.data!=null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(data: widget.data!),));
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add New Task!!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: allData.bgColor
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: TextField(
                          controller: title,
                          decoration: InputDecoration(
                              label: Text("Title"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: allData.bgColor,
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: allData.bgColor
                                  )
                              ),
                              labelStyle: TextStyle(
                                  color: allData.bgColor
                              ),
                              suffixIcon: Icon(Icons.title,color: allData.bgColor,)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: TextField(
                          controller: des,
                          decoration: InputDecoration(
                              label: Text("Description"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: allData.bgColor,
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: allData.bgColor
                                  )
                              ),
                              labelStyle: TextStyle(
                                  color: allData.bgColor
                              ),
                              suffixIcon: Icon(Icons.description,color: allData.bgColor,)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: TextField(
                          onTap: () {
                            showDatePickerDialog();
                          },
                          controller: date,
                          readOnly: true,
                          decoration: InputDecoration(
                              label: Text("Date"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: allData.bgColor,
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: allData.bgColor
                                  )
                              ),
                              labelStyle: TextStyle(
                                  color: allData.bgColor
                              ),
                              suffixIcon: Icon(Icons.date_range,color: allData.bgColor,)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: TextField(
                          onTap: () {
                            showTimePickerDialog();
                          },
                          controller: time,
                          readOnly: true,
                          decoration: InputDecoration(
                              label: Text("Time"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: allData.bgColor,
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: allData.bgColor
                                  )
                              ),
                              labelStyle: TextStyle(
                                  color: allData.bgColor
                              ),
                              suffixIcon: Icon(Icons.access_time_filled_outlined,color: allData.bgColor,)
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          add_task();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          margin: EdgeInsets.only(left: 15,right: 15),
                          child: Text("ADD",
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
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  Future<void> showDatePickerDialog() async {
    var selectDate=await showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime(DateTime.now().year+1));
    if(selectDate!=null){
      date.text=selectDate.toString().split(" ")[0];
      // date.text="${date.text.split("-")[2]}-${date.text.split("-")[1]}-${date.text.split("-")[0]}";
      date.text=date.text=="null"?"":"${date.text.split("-")[2]}-${date.text.split("-")[1]}-${date.text.split("-")[0]}";
    }
    setState(() {});
  }

  Future<void> showTimePickerDialog() async {
    var selectTime=await showTimePicker(context: context, initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
    if(selectTime!=null){
      var period = selectTime.period == DayPeriod.am ? "AM" : "PM";
      time.text = "${selectTime.hourOfPeriod}:${selectTime.minute==0?"00":selectTime.minute} $period";
    }
    setState(() {});
  }

  Future<void> add_task() async {
    if(title.text!="" && des.text!="" && date.text!="" && time.text!=""){
      if(widget.data==null){
        var ref=Boxes.getTaskRef();
        taskModel data=taskModel(title.text, des.text, date.text, time.text, await preferences.getUserEmail(),false);
        ref.add(data);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }else{
        widget.data!.title=title.text;
        widget.data!.des=des.text;
        widget.data!.date=date.text;
        widget.data!.time=time.text;
        widget.data!.save();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailsPage(data: widget.data!,),));
      }
    }else{
      allData.toast("Please Fill the Field.");
    }

  }

  void setData() {
    if(widget.data!=null){
      title.text=widget.data!.title;
      des.text=widget.data!.des;
      date.text=widget.data!.date;
      time.text=widget.data!.time;
    }
  }

}
