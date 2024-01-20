import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/model/FlowerModel.dart';
import 'package:samrt_garden/model/Plant.dart';
import 'package:samrt_garden/model/PlantModel.dart';
import 'package:samrt_garden/screen/AddPlantsScreen.dart';
import 'package:samrt_garden/screen/LoginScreen.dart';
import 'package:samrt_garden/services/services.dart';
import 'package:samrt_garden/utils/Constant.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';
import 'package:samrt_garden/widget/LampWidget.dart';
import 'package:samrt_garden/widget/PumpWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udp/udp.dart';

class testUI extends StatefulWidget {
  const testUI({Key? key}) : super(key: key);

  @override
  State<testUI> createState() => testUIState();
}

class testUIState extends State<testUI> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'IndRecord',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      body:

      Stack(
          alignment: Alignment.topCenter,
          children: [
      Container(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset("assets/images/image_back2_shadow.png"),
                  ),
                  new SingleChildScrollView(child:
                  Column(
                    children: [
                      SizedBox(height: 60,),
                      Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(colors: [
                                Colors.lightGreen.shade100,
                                Colors.lightGreen.shade100,
                              ])),
                          child:

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                  child:
                               Center(child:
                                      Text(
                                        'Speaker 1',
                                        style: TextStyle(color: Colors.green,fontSize: 17),
                                      )),

                                  onTap: () {


                                  }),


                            ],)
                      ),
                      //  getFirstWidget(isChange),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(colors: [
                              Colors.black12,
                              Colors.black12,
                            ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child:Text(
                                'Trust',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                '9',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(colors: [
                              Colors.black12,
                              Colors.black12,
                            ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child:
                              Text(
                                'Empathy',
                                style: TextStyle(color: Colors.black),
                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                '4',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(colors: [
                              Colors.black12,
                              Colors.black12,
                            ])),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child:
                                  Text(
                                    'Senti',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    '8',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(colors: [
                              Colors.black12,
                              Colors.black12,
                            ])),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child:
                                  Text(
                                    'charisma',
                                    style: TextStyle(color: Colors.black),
                                  ),//put edit
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    '7',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(colors: [
                              Colors.black12,
                              Colors.black12,
                            ])),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child:
                                  Text(
                                    'overall',
                                    style: TextStyle(color: Colors.black),
                                  ),//put edit
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    '7',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 10,),

                    ],
                  ))
                ],


              ))),

        Positioned(
            top:0,
            left: 40,
            child:
            GestureDetector(
                onTap: () async {
                  // Navigator.pushReplacementNamed(context, "/verification");

                },child:
            Container(
                height: 52,
                width: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey) ,
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10)),
                child:Center(child:
                  Text(
                    'Full Audio',
                    style: TextStyle(color: Colors.black),
                  ),
                )))
        ),
        Positioned(
            top:0,
            left: 140,
            child:
            GestureDetector(
                onTap: () async {
                  // Navigator.pushReplacementNamed(context, "/verification");

                },child:
            Container(
                height: 52,
                width: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey) ,
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10)),
                child:Center(child:
                  Text(
                    'Summery',
                    style: TextStyle(color: Colors.black),
                  ),
                )))
        ),
        Positioned(
            top:0,
            left: 240,
            child:
            GestureDetector(
                onTap: () async {
                  // Navigator.pushReplacementNamed(context, "/verification");

                },child:
            Container(
                height: 52,
                width: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey) ,
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(10)),
                child:Center(child:
                  Text(
                    'FullText',
                    style: TextStyle(color: Colors.black),
                  ),
                ))))

    ])
    );
  }



  navigationToHome(){
    if(mounted) {

      Navigator.pushReplacementNamed(context, "/main_tab_bar");
    }
  }

}
