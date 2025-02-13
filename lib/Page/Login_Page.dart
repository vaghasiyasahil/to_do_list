import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list/Model/Data_Model.dart';
import 'package:to_do_list/Page/Home_Page.dart';
import 'package:to_do_list/Services/preferences.dart';
import '../Services/Boxes.dart';
import '../Services/allData.dart';
import 'Register_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isShowPassword=true;
  bool loginTemp=true;
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          SystemNavigator.pop();
        },
        child: SafeArea(
      child: Scaffold(
        // backgroundColor: allData.bgColor.shade50,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Text(
                    "Welcome Back!!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: allData.bgColor
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
                      "Not a member?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return RegisterPage();
                        },));
                      },
                      child: Text(
                        "Sign up now",
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
                    loginUser();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Lottie.asset(
                      "${allData.animationPath}login.json",
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
  NavigatorPop(){
    SystemNavigator.pop();
  }

  void loginUser() {
    if(email.text!="" && password.text!=""){
     Box<userModel> ref=Boxes.getUserReg();
     List<userModel> userList=ref.values.toList();
     for(int i=0;i<userList.length;i++){
       if(userList[i].email==email.text && userList[i].password==password.text){
         preferences.setUserLoginStatus(true);
         preferences.setUserEmail(email.text);
         loginTemp=false;
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
       }
     }
     if(loginTemp){
       allData.toast("Wrong Email and Password");
     }
    }else{
      allData.toast("Please Fill the Field.");
    }
  }
}
