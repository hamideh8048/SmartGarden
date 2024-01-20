import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samrt_garden/config/size_config.dart';
import 'package:samrt_garden/screen/LaunchScreen.dart';
import 'package:samrt_garden/screen/LoginScreen.dart';
import 'package:samrt_garden/screen/RegisterScreen.dart';
import 'package:samrt_garden/utils/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }

}

class SplashScreenState extends State<SplashScreen> {

  bool isRegister = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer _timer;
    delete();
    _timer = new Timer(const Duration(seconds: 3), () {
      setState(() {
        navigationPage();
      });
    });
  }

  Future<void> delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('IS_EXIST_GARDEN', false);
    preferences.commit();
  }

  Future<void> navigationPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('FLOWER1', '');
    preferences.commit();
    if (preferences.getBool('REGISTERED') != null &&  preferences.getBool('REGISTERED')==true) {

        if (preferences.getString('token') != null &&preferences.getString('token') .toString().length>2) {
          Navigator
              .of(context)
              .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LaunchScreen()));
        }
        else
        {
        Navigator
            .of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
      }}else
    if (preferences.getString('token') != null &&preferences.getString('token') .toString().length>2) {
      Navigator
          .of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LaunchScreen()));
    }else
      {
        Navigator
            .of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
      }


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/green_chall_logo.png", width: 300, height: 300),
                  Padding(padding: EdgeInsets.all(12)),
                  Text("کشاورزی در خانه با گرین چال", style: TextStyle(color: Colors.green,fontSize: 18),),
                ],
              )),
          Container(child:Image.asset("assets/images/image_back_shadow.png"),alignment: Alignment.bottomCenter,)
        ],
      ),
    );
  }

}