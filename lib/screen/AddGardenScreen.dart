import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/model/FlowerModel.dart';
import 'package:samrt_garden/screen/AddNewGardenWithDetailsScreen.dart';
import 'package:samrt_garden/screen/InsertNewGarden.dart';
import 'package:samrt_garden/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GardenDetailsScreen.dart';

class AddGardenScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddGardenScreenState();
  }
}

class AddGardenScreenState extends State<AddGardenScreen> {
  bool loading=true;
  Future<void> save(FlowerModel model) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GardenDetailsScreen(flowerModel:model ,)),
    );
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setBool("IS_EXIST_GARDEN", true);
    // preferences.commit();
    // Fluttertoast.showToast(
    //     msg: "باغچه با موفقیت افزوده شد!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    // Navigator.pop(context);
  }
  List<FlowerModel> flowerList = [];
  ShowPots() async {
    try{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    if (token != null && token.length > 2) {
      var response = await (Services().getUserFlowers(
      //  "798dc65b63639dcb471bd748acee896ae7fdd3fd"));
       token));
      loading=false;
      if (response != null && response.length>0) {
        response.forEach((element){
          flowerList.add(FlowerModel .fromJson(element));
          //  taradods.add(TaradodListModel.fromJson(element));
        });

        //   SharedPreferences preferences = await SharedPreferences.getInstance();
        //   setState(() {
        //     preferences.setBool("REGISTERED", true);
        //     preferences.setString("EMAIL", email);
        //     preferences.setString("PASSWORD", password);
        //     preferences.commit();
        //   });
        //   Fluttertoast.showToast(
        //       msg: " ثبت نام انجام شد",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        //   Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     //builder: (BuildContext context) => LaunchScreen()));
        //       builder: (BuildContext context) => LoginScreen()));
        // }
        // else
        // {
        //   Fluttertoast.showToast(
        //       msg: "خطای  ثبت نام",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        //   //customNotification(false,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
        //
        // }
      }
      setState(() {

      });
    }
    } catch (error) {
      print(error);
      setState(() {
       loading = false;
      });
    }
  }
  @override
  void initState() {
    ShowPots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          ' باغچه من',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body:
      loading?
      Center(child:

      Container(
        width: 54,
        height: 54,
        padding: const EdgeInsets.all(2.0),
        child: const CircularProgressIndicator(
          color: Colors.green,
          strokeWidth: 3,
        ),
      )
      ):
      // SingleChildScrollView(child:
      //     Column(
      //       children: [
      //         GestureDetector(
      //           onTap: () {
      //
      //             Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                 builder: (BuildContext context) => InsertNewGarden()));
      //           },
      //           child: Container(
      //             height: 50,
      //             width: 360,
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(10),
      //                 gradient: LinearGradient(colors: [
      //                   Colors.lightGreen,
      //                   Colors.lightGreen,
      //                 ])),
      //             child: Center(
      //                 child: Text(
      //                   "افزودن باغچه جدید",
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold),
      //                 )),
      //           ),
      //         ),
      Stack(
          children: [
      Padding(
      padding: EdgeInsets.only(left: 20),child:
                    GestureDetector(
                      onTap: () {

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => InsertNewGarden()));
                      },
                      child: Container(
                        height: 50,
                        width: 340,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Colors.lightGreen,
                              Colors.lightGreen,
                            ])),
                        child: Center(
                            child: Text(
                              "افزودن باغچه جدید",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    )),
    Padding(
    padding: EdgeInsets.only(top: 50),child:
              Container(
                child:
                ListView.builder(
                    itemCount:flowerList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return

                        Padding(
                            padding: EdgeInsets.all(24),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(colors: [
                                    Colors.lightGreen.shade100,
                                    Colors.lightGreen.shade100,
                                  ])),
                              child: Column(
                                children: [
                                  Text(
                                    flowerList[index].name + flowerList[index].serial_number,
                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                  ),
                                  Padding(padding: EdgeInsets.all(12)),
                                  Image.asset(
                                    "assets/images/sp1.png",
                                    width: 150,
                                  ),
                                  Padding(padding: EdgeInsets.all(12)),
                                  new GestureDetector(
                                    onTap: () {
                                      save(flowerList[index]);
                                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      //     builder: (BuildContext context) => AddNewGardenWithDetailsScreen()));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 360,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(colors: [
                                            Colors.lightGreen,
                                            Colors.lightGreen,
                                          ])),
                                      child: Center(
                                          child: Text(
                                            "انتخاب",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ));}


                ),
              )),
      ])
      //       ],
      //     )
      // )

    );
  }
}
