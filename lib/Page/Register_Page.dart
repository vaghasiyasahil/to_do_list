import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/Model/Data_Model.dart';
import 'package:to_do_list/Page/Home_Page.dart';
import 'package:to_do_list/Services/preferences.dart';
import '../Services/Boxes.dart';
import '../Services/allData.dart';
import 'Login_Page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isShowPassword=true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      },
      child: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                margin: EdgeInsets.only(top: 100),
                  child: Lottie.asset(
                      "assets/animation/create_ac.json",
                      height: 150,
                      width: 150
                  ),
                ),
                Text(
                  "Create Account!!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: allData.bgColor
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                        label: Text("Name"),
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
                        prefixIcon: Icon(Icons.account_circle,color: allData.bgColor,),
                        suffixIcon: Icon(Icons.account_circle_outlined,color: allData.bgColor,)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        label: Text("Email"),
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
                        prefixIcon: Icon(Icons.email,color: allData.bgColor,),
                        suffixIcon: Icon(Icons.email_outlined,color: allData.bgColor,)
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: TextField(
                    controller: password,
                    obscureText: isShowPassword,
                    decoration: InputDecoration(
                      label: Text("Password"),
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
                      prefixIcon: Icon(Icons.lock,color: allData.bgColor,),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isShowPassword=!isShowPassword;
                          setState(() {

                          });
                        },
                        icon: Icon(isShowPassword?Icons.visibility:Icons.visibility_off,color: allData.bgColor,),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have already an account?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        },));
                      },
                      child: Text(
                        "Login here",
                        style: TextStyle(
                            fontSize: 15,
                            color: allData.bgColor
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    registerUser();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Lottie.asset(
                      "assets/animation/register.json",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }

  void registerUser() {
    if(name.text!="" && email.text!="" && password.text!=""){
      var ref=Boxes.getUserReg();
      List<userModel> userList=ref.values.toList();
      for(int i=0;i<userList.length;i++){
        if(userList[i].email==email.text){
          allData.toast("Another account is using the same email.");
          return;
        }
      }
      userModel data=userModel(name.text, email.text, password.text);
      ref.add(data);
      preferences.setUserEmail(email.text);
      preferences.setUserLoginStatus(true);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }else{
      allData.toast("Please Fill the Field.");
    }
  }
}
