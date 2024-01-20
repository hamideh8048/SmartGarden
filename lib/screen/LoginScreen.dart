import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/screen/ChangePasswordScreen.dart';
import 'package:samrt_garden/screen/LaunchScreen.dart';
import 'package:samrt_garden/screen/RegisterScreen.dart';
import 'package:samrt_garden/services/services.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {


  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  late NotificationHelper _notificationHelper;
  String email = '';
  String password = '';

  static const List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'ورود',
        style: TextStyle(fontSize: 28, fontFamily: 'myFont'),
      ),
    ),
    Tab(
      child: Text(
        'ثبت نام1',
        style: TextStyle(fontSize: 28, fontFamily: 'myFont'),
      ),
    ),
  ];

  late TabController _tabController1;

  loginTo(String phone,String password) async {
    var response = await (Services()).login(
        phone,password);
    if (response['token'] != null &&response['token'].toString().length>1)
    {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {

        preferences.setString("token", response['token']);

        preferences.commit();
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
       builder: (BuildContext context) => LaunchScreen()));
       //   builder: (BuildContext context) => LoginScreen()));
    }
    else
    {
      Fluttertoast.showToast(
          msg: "خطای ورود به سیستم",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      //customNotification(false,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);

    }
  }


  @override
  void initState() {
    super.initState();
   // getInformation();
    _tabController1 = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController1.dispose();
    super.dispose();
  }

  Future<void> getInformation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('EMAIL') != null) {
      email = preferences.getString('EMAIL')!;
      password = preferences.getString('PASSWORD')!;
    }

  }

  Future<void> login(String enteredEmail,String enteredPassword) async {

    if (email != '') {
      if(email == enteredEmail){
        if(password == enteredPassword){
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("REGISTERED", true);
          preferences.commit();
          Navigator
              .of(context)
              .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LaunchScreen()));
        }else{
          Fluttertoast.showToast(
              msg: "رمز ورود صحیح نمی باشد!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }else{
        Fluttertoast.showToast(
            msg: "ایمیل صحیح نمی باشد!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }else{
      Fluttertoast.showToast(
          msg: "لطفا ابتدا در اپلیکیشن ثبت نام نمائید!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child:Image.asset("assets/images/image_back2_shadow.png"),),
          Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'به گرین چال خوش آمدید',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'شماره موبایل',
                            style: TextStyle(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8,),
                          TextField(
                            controller: controllerEmail,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: 'شماره موبایل خود را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'رمز ورود',
                            style: TextStyle(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8,),
                          TextField(
                            controller: controllerPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: 'رمز ورود خود را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => ChangePasswordScreen()));
                          },
                          child: Text(
                            'رمز خود را فراموش کردید؟',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                      onTap: () {
                      //  login(controllerEmail.text, controllerPassword.text);
                        loginTo(controllerEmail.text, controllerPassword.text);
                      },
                      child: Container(
                        height: 50,
                        width: 360,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(colors: [
                              Colors.green,
                              Colors.green,
                            ])),
                        child: Center(
                            child: Text(
                              "ورود",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) => RegisterScreen()));
                        },
                        child: Container(
                          height: 50,
                          width: 360,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.orange),
                              color: Colors.orange,
                              gradient: LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ])),
                          child: Center(
                              child: Text(
                                "ثبت نام",
                                style: TextStyle(
                                    color: Colors.orange, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
