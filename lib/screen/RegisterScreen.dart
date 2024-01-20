import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:samrt_garden/screen/LaunchScreen.dart';
import 'package:samrt_garden/screen/LoginScreen.dart';
import 'package:samrt_garden/screen/otpScreen.dart';
import 'package:samrt_garden/services/services.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin
   {
  late NotificationHelper _notificationHelper;
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerphone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerRepeatPassword = TextEditingController();


  static const List<Tab> myTabs = <Tab>[
    Tab(
      child: Text(
        'ورود',
        style: TextStyle(fontSize: 28, fontFamily: 'myFont'),
      ),
    ),
    Tab(
      child: Text(
        'ثبت نام',
        style: TextStyle(fontSize: 28, fontFamily: 'myFont'),
      ),
    ),
  ];

  late TabController _tabController1;

  @override
  void initState() {
    super.initState();
    _tabController1 = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController1.dispose();
    super.dispose();
  }

  saveInPref(String email,String phone,String password) async {
    var response = await (Services()).register(
        email,phone,password);
    if (response['full_name'] != null &&response['full_name'].toString().length>1)
    {
      var responseotp = await (Services()).loginotp(phone);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("REGISTERED", true);
      preferences.setString("EMAIL", email);
      preferences.setString("mobile", phone);
      preferences.commit();
    });
    // Fluttertoast.showToast(
    //     msg: " ثبت نام انجام شد",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    Navigator.of(context).pushReplacement(MaterialPageRoute(

       // builder: (BuildContext context) => LoginScreen()));
        builder: (BuildContext context) => OTPScreen()));
  }
    else
      {
        Fluttertoast.showToast(
            msg: "error: "+response,
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
                      'عضویت در گرین چال',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'نام و نام خانوادگی',
                            style: TextStyle(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8,),
                          TextField(
                            controller: controllerEmail,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: 'نام و نام خانوادگی خود را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'موبایل',
                            style: TextStyle(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8,),
                          TextField(
                            controller: controllerphone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: 'موبایل خود را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'تکرار رمز ورود',
                            style: TextStyle(),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8,),
                          TextField(
                            controller: controllerRepeatPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: 'تکرار رمز ورود خود را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {

                        if(controllerEmail.text == '' || controllerPassword.text == '' || controllerRepeatPassword == ''){
                          Fluttertoast.showToast(
                              msg: "فیلد ها بایستی کامل پر شود!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }else{
                          if(controllerPassword.text == controllerRepeatPassword.text){
                            saveInPref(controllerEmail.text,controllerphone.text, controllerPassword.text);
                          }else{
                            Fluttertoast.showToast(
                                msg: "رمز ورود و تکرار آن مغایرت دارد!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }

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
                              "تایید",
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
                              builder: (BuildContext context) => LoginScreen()));
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
                                "بازگشت به صفحه ورود",
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
