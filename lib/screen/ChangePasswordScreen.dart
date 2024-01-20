import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/screen/LaunchScreen.dart';
import 'package:samrt_garden/screen/LoginScreen.dart';
import 'package:samrt_garden/screen/RegisterScreen.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';
import 'package:samrt_garden/widget/WebViewContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/services.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePasswordScreenState();
  }
}

class ChangePasswordScreenState extends State<ChangePasswordScreen>
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
        'ثبت نام',
        style: TextStyle(fontSize: 28, fontFamily: 'myFont'),
      ),
    ),
  ];

  late TabController _tabController1;

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

  Future<void> getVerificationCode() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString('mobile')!=null) {
   //if(true) {
    String mobile = preferences.getString('mobile')!;
   // String mobile="09126837491";

    //var responseotp = await (Services()).loginotp("09126837491");
    //  var response2 = await (Services()).validateOtp(
    //      mobile,"4708"); //m
     var response = await (Services()).resetPass(
         mobile); //mobile.toString());

  // var response3 = await (Services()).resetPass("09126837491");
 // var response2 = await (Services()).resetPassValidateOtp("09126837491","0708");
   //  var response = await (Services()).resetPass("09126837491");
      if (response != null && response
          .toString()
          .length > 1) {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //
        // preferences.setString("token", response['token'].toString());
        //
        // preferences.commit();

        Fluttertoast.showToast(
            msg: "  بازنشانی رمز عبور انجام شد",
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
            msg: "خطای   تغییر رمز",
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
  Future<void> changePass() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString('mobile')!=null) {
      // if(true) {
      String mobile = preferences.getString('mobile')!;
      // String mobile="09126837491";

      //var responseotp = await (Services()).loginotp("09126837491");
      //  var response2 = await (Services()).validateOtp(
      //      mobile,"4708"); //m
      var response = await (Services()).resetPassValidateOtp(
          mobile,controllerEmail.text); //mobile.toString());

      // var response3 = await (Services()).resetPass("09126837491");
      // var response2 = await (Services()).resetPassValidateOtp("09126837491","0708");
      //  var response = await (Services()).resetPass("09126837491");
      if (response!= null && response.toString().contains("Go to this link to reset your password")
          ) {
        String url=response.toString().replaceAll("Go to this link to reset your password:", "");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewContainer(
                  url
              )),
        );
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //
        // preferences.setString("token", response['token'].toString());
        //
        // preferences.commit();

      }

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
                      'بازنشانی رمز ورود',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                    SizedBox(
                      height: 44,
                    ),
                    GestureDetector(
                      onTap: () {
                        getVerificationCode();
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
                              "دریافت کد تایید",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    // Container(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //         'رمز عبور جدید',
                    //         style: TextStyle(),
                    //         textAlign: TextAlign.right,
                    //         textDirection: TextDirection.rtl,
                    //       ),
                    //       SizedBox(height: 8,),
                    //       TextField(
                    //         controller: controllerPassword,
                    //         keyboardType: TextInputType.visiblePassword,
                    //         obscureText: true,
                    //         enableSuggestions: false,
                    //         autocorrect: false,
                    //         decoration: InputDecoration(
                    //             border: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Colors.greenAccent),
                    //               borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    //             ),
                    //             hintText: 'رمز ورود جدید خود را وارد نمائید',
                    //             hintTextDirection: TextDirection.rtl
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 24,
                    // ),
                    // Container(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //         'تکرار رمز ورود جدید',
                    //         style: TextStyle(),
                    //         textAlign: TextAlign.right,
                    //         textDirection: TextDirection.rtl,
                    //       ),
                    //       SizedBox(height: 8,),
                    //       TextField(
                    //         controller: controllerPassword,
                    //         keyboardType: TextInputType.visiblePassword,
                    //         obscureText: true,
                    //         enableSuggestions: false,
                    //         autocorrect: false,
                    //         decoration: InputDecoration(
                    //             border: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Colors.greenAccent),
                    //               borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    //             ),
                    //             hintText: 'رمز ورود جدید خود را وارد نمائید',
                    //             hintTextDirection: TextDirection.rtl
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 12,
                    // ),
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                ),
                                hintText: 'کد تایید را وارد نمائید',
                                hintTextDirection: TextDirection.rtl
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                     //   login(controllerEmail.text, controllerPassword.text);
                        if(controllerEmail.text!=null &&controllerEmail.text.length>1)
                        changePass();
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
                              "بازنشانی",
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
