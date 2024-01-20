import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/screen/AddGardenScreen.dart';
import 'package:samrt_garden/screen/ChangePasswordScreen.dart';
import 'package:samrt_garden/screen/LaunchScreen.dart';
import 'package:samrt_garden/screen/RegisterScreen.dart';
import 'package:samrt_garden/services/services.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertNewGarden extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InsertNewGardenState();
  }
}

class InsertNewGardenState extends State<InsertNewGarden>
    {


  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerSerial = TextEditingController();

  late NotificationHelper _notificationHelper;
  String email = '';
  String password = '';
bool loading=false;

  SavePot(String name,String serial) async {
    try{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = "";
    setState(() {
      loading=true;
    });
  if(  preferences.getString('token')!=null)
     token = preferences.getString('token')!;
    var response = await (Services()).registerUpdateFlowerpot(
        token,serial,false,false,false,false,"0","0",[],name);

    if (response['id'] != null &&response['id'].toString().length>1)
    {
      Fluttertoast.showToast(
          msg: "گلدان با موفقیت ثبت شد",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else
    {
      Fluttertoast.showToast(
          msg: "خطای ثبت گلدان",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      //customNotification(false,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);

    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddGardenScreen()),
    );
    setState(() {
      loading=false;
    });

    } catch (error) {
      setState(() {
        loading=false;
      });
    }
  }


  @override
  void initState() {
    super.initState();
   // getInformation();

  }

  @override
  void dispose() {

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25,),
                    Text(
                      'اضافه کردن گلدان',
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
                            '1.وارد تنظیمات گوشی خود شوید',
                            style: TextStyle(color:  Colors.green),
                            textAlign: TextAlign.right,

                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            '2.وای فای گلدان را پیدا کنید و روی آن کلیک کنید',
                            style: TextStyle(color:  Colors.green),
                            textAlign: TextAlign.right,

                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            '3.در صفحه باز شده نام کاربری و رمز وای فای نزدیک به گلدان را پیدا کنید',
                            style: TextStyle(color:  Colors.green),
                            textAlign: TextAlign.right,

                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                              '4.تبریک ! گلدان شما به اینترنت متصل شده است حالابرای گلدان خود اسم انتخاب کنید',
                            style: TextStyle(color:  Colors.green),
                            textAlign: TextAlign.right,

                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'نام گلدان ',
                            style: TextStyle(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8,),
                          TextField(
                            controller: controllerName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: '  نام گلدان را وارد نمائید',
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
                            ' سریال',
                            style: TextStyle(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8,),
                          TextField(
                            controller: controllerSerial,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: ' سریال را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                      //  login(controllerEmail.text, controllerPassword.text);
                        SavePot(controllerName.text, controllerSerial.text);
                      },
                      child:
                      loading?
                      Container(
                        margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                        width: 10,
                        height: 10,
                        child: const CircularProgressIndicator(
                          color: Colors.green,
                          strokeWidth: 3,
                        ),
                      ):
                      Container(
                        height: 50,
                        width: 360,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(colors: [
                              Colors.green,
                              Colors.green,
                            ])),
                        child:

                        Center(
                            child: Text(
                              "ثبت",
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
