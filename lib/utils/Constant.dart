
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:samrt_garden/model/Plant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
class Constant{

  static final String IS_REGISTERED = "IS_REGISTERED";
  static final String LAST_DATE = "LAST_DATE";
  static final String LAST_TIME = "LAST_TIME";
  static final String HAS_PASSWORD = "HAS_PASSWORD";
  static final String MOBILE = "MOBILE";
  static final String TOKEN = "TOKEN";
  static final String FULL_NAME = "FULL_NAME";
  static final String EMAIL = "EMAIL";
  static final String PASSWORD = "PASSWORD";
  static final String MAX_TEMP = "MAX_TEMP";
  static final String TIMER_MOTION = "TIMER_MOTION";
  static final String TIMER_SLEEP = "TIMER_SLEEP";
  static final String TIMER_TOGGLE = "TIMER_TOGGLE";
  static final String TIMER_PERIOD_TOGGLE = "TIMER_PERIOD_TOGGLE";
  static final String LAMP_MOTION = "LAMP_MOTION";
  static final String LAMP_SLEEP = "LAMP_SLEEP";
  static final String LAMP_TOGGLE = "LAMP_TOGGLE";
  static final String LAST_CLIENT = "LAST_CLIENT";
  static final String NOTIFICATION_ID = "NOTIFICATION_ID";



  // static final String API_URL_SERVER = "192.168.1.155:8001";
  static final String API_URL_SERVER = "94.183.115.164:8001";
  static final String GET_TOKEN = "api/auth/token";
  static final String SEND_SMS = "api/auth/sendSms";
  static final String CHECK_CODE = "api/auth/checkCode";
  static final String INSERT_DEVICE = "api/auth/insertDevice";


  static String Authorization = "TOKEN";


  static int MAX_TEMP_ALERT = 40;
  static bool NOTIFICATION_SERVICE = true;

  static bool IS_SET_SETTINGS = false;
  static String OPTION_SETTINGS = "";

  static List<Plant> plantList = [];


  OverlaySupportEntry acustomNotification(bool isError,String title,double
  width,double height){
    return showSimpleNotification(

      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: width,
                height: 60,
                child: Text(title)

            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: LinearPercentIndicator(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                animationDuration: 3800,
                percent: 1,
                progressColor:isError ? Colors.red : Colors.green,
                animateFromLastPercent: true,
                animation: true,
              ),
            )
          ],
        ),
      ),duration: const Duration(seconds: 10),
      elevation: 25,
      background: Colors.transparent,
    );
  }



}