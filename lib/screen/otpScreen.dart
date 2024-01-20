import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/screen/ChangePasswordScreen.dart';
import 'package:samrt_garden/screen/LaunchScreen.dart';
import 'package:samrt_garden/screen/RegisterScreen.dart';
import 'package:samrt_garden/services/services.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class OTPScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return OTPScreenState();
  }
}

class OTPScreenState extends State<OTPScreen>
  {

    saveInPref() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if(preferences.getString('mobile')!=null) {
        String mobile = preferences.getString('mobile')!;
        var response = await (Services()).validateOtp(
            mobile,controllerEmail.text); //mobile.toString());
        //var response = await (Services()).resetPass("09126837491");
        if (response['token'] != null && response['token']
            .toString()
            .length > 1) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
            //preferences.setBool("REGISTERED", true);
            preferences.setString("token", response['token'].toString());
            // preferences.setString("mobile", phone);
            preferences.commit();

          Fluttertoast.showToast(
              msg: " ثبت نام انجام شد",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(MaterialPageRoute(

            // builder: (BuildContext context) => LoginScreen()));
              builder: (BuildContext context) => LoginScreen()));
        }
        else {
          Fluttertoast.showToast(
              msg: "خطای  ثبت نام",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          //customNotification(false,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);

        }
      }
    }

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


  }

  @override
  void dispose() {
    _tabController1.dispose();
    super.dispose();
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
                    // Text(
                    //   'به گرین چال خوش آمدید',
                    //   style: TextStyle(color: Colors.black, fontSize: 24),
                    // ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'کد تایید',
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
                                hintText: 'کد تایید  را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                      onTap: () {
                      //  login(controllerEmail.text, controllerPassword.text);
                     //   loginTo(controllerEmail.text, controllerPassword.text);
                        if(controllerEmail.text!=""&&controllerEmail.text.length>1)
                        saveInPref();
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
                              "ثبت کد تایید",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            )),
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
