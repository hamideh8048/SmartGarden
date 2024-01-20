import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/screen/PlantDetailsScreen.dart';
import 'package:samrt_garden/utils/Constant.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationsScreenState();
  }
}

class NotificationsScreenState extends State<NotificationsScreen> {

  bool state = true;

  late NotificationHelper _notificationHelper;

  void setNotification(){

    _notificationHelper = NotificationHelper();
    _notificationHelper.initializeNotification();
    for(int i = 0 ; i < 24 ; i++) {
      for (int j = 0; j < 3; j++) {
        _notificationHelper.scheduledNotification(
          hour: int.parse('${i}'),
          minutes: int.parse('${j*20}'),
          id: int.parse('${i}${j*20}'),
          sound: '',
        );
      }
    }

  }

  void cancelNotification(){
    _notificationHelper = NotificationHelper();
    _notificationHelper.initializeNotification();
    _notificationHelper.cancelAll();
  }

  Future<void> getNotificationState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getBool('NOTIFICATION_STATE')!=null) {
      state = preferences.getBool('NOTIFICATION_STATE')!;
    }else{
      state = true;
    }
    setState(() {
      state;
    });
  }

  Future<void> changeNotificationState(bool state) async {
    this.state = state;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('NOTIFICATION_STATE', state);
    preferences.commit();
    setState(() {
      state;
    });
    if(preferences.getString('FLOWER1')!=null || preferences.getString('FLOWER1')!=''){
      if(state){
        setNotification();
      }else{
        cancelNotification();
      }
    }else{
      Fluttertoast.showToast(
        msg: "عدم وجود باغچه یا گیاه در دوره کاشت",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          'اعلانات',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child:Container(
        height: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: [
              Colors.lightGreen.shade100,
              Colors.lightGreen.shade100,
            ])),
        child: Column(
          children: [
            Text('در صورت عدم فعالسازی اعلانات برای شما نمایش داده نخواهد شد.',style: TextStyle(fontSize: 14),textDirection: TextDirection.rtl,),
            Padding(padding: EdgeInsets.all(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Switch(value: state, onChanged: (bool value) {
                    if(state){
                      changeNotificationState(false);
                    }else{
                      changeNotificationState(true);
                    }
                  },),
                ),
                Padding(padding: EdgeInsets.all(12),
                  child:Text('فعال',style: TextStyle(color: Colors.black),),),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
