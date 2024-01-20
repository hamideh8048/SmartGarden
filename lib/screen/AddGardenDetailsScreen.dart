import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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

class AddGardenDetailsScreen extends StatefulWidget {
  const AddGardenDetailsScreen({Key? key,required this.flowerModel}) : super(key: key);

  final  FlowerModel flowerModel;
  @override
  State<StatefulWidget> createState() {
    return AddGardenDetailsScreenState();
  }
}

class AddGardenDetailsScreenState extends State<AddGardenDetailsScreen>
    with WidgetsBindingObserver {
  List<DropdownMenuItem<String>> dropdownPompItems = [];
  var newPompItem = DropdownMenuItem(
    child: Text("هر ۹ ساعت",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
    key: UniqueKey(),
    value: "9",
  );
  var newPompItem2 = DropdownMenuItem(
    child: Text("هر ۱۲ ساعت",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
    key: UniqueKey(),
    value: "12",
  );
  var newPompItem3 = DropdownMenuItem(
    child: Text("هر ۱۵ ساعت",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
    key: UniqueKey(),
    value: "15",
  );
  var newPompItem4 = DropdownMenuItem(
    child: Text("هر ۱۸ ساعت",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
    key: UniqueKey(),
    value: "18",
  );
  FlowerModel?fmodel;
  MaterialColor _button_connected = Colors.green;
  MaterialColor _button_disconnected = Colors.red;
  MaterialColor _button_connecting = Colors.blue;
  late String _button_text = "اتصال به گلدان";

  ServerSocket? serverSocket;
  Socket? clientSocket;
  int port = 4310;

  // int port = 55303;
  int port_udp = 4210;
  String _log = 'Log ...';
  String _cmd_ok = 'ok,\r\n';

  bool is_connected = false;
  bool pump = false;
  bool light = false;
  String _pump_text_button = "پمپ : روشن";
  MaterialColor _pump_color_button = Colors.red;
  String _light_text_button = "لامپ : روشن";
  MaterialColor _light_color_button = Colors.red;

  String pumpDropdownValue = 'انتخاب کنید';
  String lightDropdownValue = 'انتخاب کنید';

  late Timer _timer;
  int _start = 30;
  String time = "";

  String flower1 = '', flower2 = '', flower3 = '';
  bool isFirst = true;
  bool isChange = false;
  bool isEnought = false;
  bool isEnoughtFertilizer = false;

  late NotificationHelper _notificationHelper;

  void setNotification() {
    _notificationHelper = NotificationHelper();
    _notificationHelper.initializeNotification();
    for (int i = 0; i < 24; i++) {
      for (int j = 0; j < 3; j++) {
        _notificationHelper.scheduledNotification(
          hour: int.parse('${i}'),
          minutes: int.parse('${j * 20}'),
          id: int.parse('${i}${j * 20}'),
          sound: '',
        );
      }
    }
  }

  List<PlantModel> plantList = [];
  List<PlantModel> userplantList = [];
  List<String> plants = [];
  getPlant() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    if (token != null && token.length > 2) {
      // var response2 = await (Services()).registerUpdateFlowerpot(token);
    var response = await (Services()).getPlants(token);
    if (response != null && response.length>0) {
      response.forEach((element) {
        plantList.add(PlantModel.fromJson(element));
        //  taradods.add(TaradodListModel.fromJson(element));
      });
    }
    List<String>plantliststr=[];
    plantliststr=plants;
    if(widget.flowerModel.plants.length>0)
 userplantList= plantList.where((elem) => plantliststr.contains(elem.id)).toList();

      setState(() {

      });
    }}

  updateGarden() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
getDropdown();
    var token = preferences.getString('token');
    if (token != null && token.length > 2) {
       var response = await (Services()).registerUpdateFlowerpot(token,fmodel!.serial_number,fmodel!.fertilize_status,fmodel!.light_status,fmodel!.pump_status,fmodel!.water_status,pumpValue,lightValue,plants,fmodel!.name);

      if (response != null && response["id"]!=null) {

       fmodel = FlowerModel.fromJson(response);
     //  CheckDropdown();
          //  taradods.add(TaradodListModel.fromJson(element));
      List<String>plantliststr=[];
      plants=fmodel!.plants;
      plantliststr=plants;
      if(fmodel!.plants.length>0)
        userplantList= plantList.where((elem) => plantliststr.contains(elem.id)).toList();
       Fluttertoast.showToast(
         msg: "ثبت با موفقیت انجام شد",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 2,
         backgroundColor: Colors.orange,
         textColor: Colors.white,
         fontSize: 16.0,
       );
      setState(() {

      });
    }}}

  void cancelNotification() {
    _notificationHelper = NotificationHelper();
    _notificationHelper.initializeNotification();
    _notificationHelper.cancelAll();
  }

  Future<void> sendUdp() async {
    print('Send UDP :)');

    var sender = await UDP.bind(Endpoint.broadcast(port: Port(port_udp)));

    // send a simple string to a broadcast endpoint on port 2390.
    var dataLength = await sender.send(
        "ok".codeUnits, Endpoint.broadcast(port: Port(port_udp)));

    stdout.write("$dataLength bytes sent.");

    // creates a new UDP instance and binds it to the local address and the port
    // 65002.
    var receiver = await UDP.bind(Endpoint.broadcast(port: Port(port_udp)));

    // receiving\listening
    receiver.asStream(timeout: Duration(seconds: 2)).listen((datagram) {
      var str = String.fromCharCodes(datagram!.data);
      stdout.write(str);
    });

    // close the UDP instances and their sockets.
    sender.close();
    receiver.close();
  }

String pumpValue="";
String lightValue="";
  getDropdown()
  {
    if(pumpDropdownValue.contains("15"))
      pumpValue='15';
    else
    if(pumpDropdownValue.contains("20"))
      pumpValue='20';
    else
    if(pumpDropdownValue.contains("30"))
    pumpValue='30';

    if(lightDropdownValue.contains("9"))
      lightValue='9';
    else
    if(lightDropdownValue.contains("12"))
      lightValue='12';
    else
    if(lightDropdownValue.contains("15"))
      lightValue='15';
    else
    if(lightDropdownValue.contains("18"))
      lightValue='18';
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fmodel=widget.flowerModel;
    plants=widget.flowerModel.plants;
   // updateGarden();
    getPlant();

    setState(() {

    });
    getFlowers();
    WidgetsBinding.instance?.addObserver(this);
    startServer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
    stopServer();
  }

  Future<void> isFirstFlower() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('FLOWER1') == null ||
        preferences.getString('FLOWER1') == '') {
      isFirst = true;
    } else {
      isFirst = false;
    }
    setState(() {
      isFirst;
    });
  }

  Future<void> getFlowers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('FLOWER1') != null) {
      flower1 = preferences.getString('FLOWER1')!;
      setState(() {
        flower1;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print('init state ...');
    if (state == AppLifecycleState.resumed) {
      print('init state ...');
      if (Constant.IS_SET_SETTINGS == true) {
        print('send settings ...');
        if (clientSocket != null) {
          String cmd = 'LightNormal,PumpNormal,${Constant.OPTION_SETTINGS}\r\n';
          String cmd2 = 'PumpNormal\r\n';
          String cmd3 = '${Constant.OPTION_SETTINGS}\r\n';
          clientSocket!.write('${cmd}');
          clientSocket!.write('${cmd2}');
        }
      }
    }
  }

  void startServer() async {
    serverSocket =
        await ServerSocket.bind(InternetAddress.anyIPv4, port, shared: true);
    serverSocket!.listen(handleClient);
  }

  void handleClient(Socket client) {
    clientSocket = client;

    clientSocket!.listen(
      (onData) {
        print(String.fromCharCodes(onData).trim());

        if (String.fromCharCodes(onData).trim() == 'PumpON' ||
            String.fromCharCodes(onData).trim() == 'LightON' ||
            String.fromCharCodes(onData).trim() == 'PumpOFF' ||
            String.fromCharCodes(onData).trim() == 'LightOFF') {
          _button_text = "متصل به گلدان";
          _button_connecting = Colors.green;
          is_connected = true;
          _timer.cancel();
          setState(() {
            _button_text;
            _button_connecting;
            is_connected;
          });

          if (String.fromCharCodes(onData).trim() == 'PumpON') {
            pump = true;
            _pump_text_button = "پمپ : روشن";
            _pump_color_button = Colors.green;
            setState(() {
              _pump_text_button;
              _pump_color_button;
            });
          } else if (String.fromCharCodes(onData).trim() == 'PumpOFF') {
            pump = false;
            _pump_text_button = "پمپ : خاموش";
            _pump_color_button = Colors.red;
            setState(() {
              _pump_text_button;
              _pump_color_button;
            });
          } else if (String.fromCharCodes(onData).trim() == 'LightON') {
            light = true;
            _light_text_button = "لامپ : روشن";
            _light_color_button = Colors.green;
            setState(() {
              _light_text_button;
              _light_color_button;
            });
          } else if (String.fromCharCodes(onData).trim() == 'LightOFF') {
            light = false;
            _light_text_button = "لامپ : خاموش";
            _light_color_button = Colors.red;
            setState(() {
              _light_text_button;
              _light_color_button;
            });
          }
        } else {
          clientSocket!.write('${_cmd_ok}');
          _button_text = "متصل به گلدان";
          _button_connecting = Colors.green;
          setState(() {
            _button_text;
            _button_connecting;
          });
        }
      },
      onError: (e) {
        disconnectClient(false);
      },
      onDone: () {
        disconnectClient(true);
      },
    );
  }
String pomphour=  'هر ۱۲ ساعت';
  void startTimer() {
    _start = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Fluttertoast.showToast(
              msg: "به گلدان متصل نشدید! مجدد تلاش کنید.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.orange,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            disconnectClient(false);
          });
        } else {
          setState(() {
            _start--;
            time;
          });
        }
      },
    );
  }
 // List<DropdownMenuItem<String>> dropdownPompItems = [];
  void stopServer() {
    disconnectClient(true);
    serverSocket!.close();
    // _button_connecting = Colors.blue;
    // _button_text = "اتصال به گلدان";
    // setState(() {
    //   _button_text;
    //   _button_connecting;
    // });
  }

  void disconnectClient(bool isDispose) {
    if (clientSocket != null) {
      clientSocket!.close();
      clientSocket!.destroy();
    }
    if (!isDispose) {
      _button_connecting = Colors.blue;
      _button_text = "اتصال به گلدان";
      is_connected = false;
      setState(() {
        _button_text;
        _button_connecting;
        is_connected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        elevation: 0,
        title: Text(
         "گلدان ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
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


                      Container(
                            height: 115,
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
  height: 10,
),
                              GestureDetector(
                                child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'افزودن گل و گیاه',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Icon(
                                          Icons.add_box_outlined,
                                          color: Colors.green,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        )
                                      ],
                                    ),
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddPlantsScreen()),
                                ).then((value) async {
                                  if(userplantList.where((element) => element.id==value).firstOrNull==null) {
                                    PlantModel? pmodel = plantList
                                        .where((elem) => value == elem.id)
                                        .firstOrNull;
                                    if (pmodel != null) {
                                      userplantList.add(pmodel);
                                      print("i am here");
                                      plants.add(value);
                                    }
                                    setState(() {

                                    });
                                  }
                                });
                                }),

                              Container(
                                height: 80,child:
                          ListView(

                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                             userplantList.length,
                                  (i) => Container(
                                width: 60,
                                child:
                                CachedNetworkImage(
                                  height: 60,
                                  width: 60,
                                  imageUrl: userplantList[i].url,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      Container(
                                        margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                                        width: 10,
                                        height: 10,
                                        child: const CircularProgressIndicator(
                                          color: Colors.green,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                )
                                // Image.asset(
                                //   "assets/images/tare.png",
                                //   width: 64,
                                //   height: 64,
                                // )

                              ),
                            ),

                          ))
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
                              child: Switch(
                                value: is_connected,
                                onChanged: (bool value) {
                                  print('before send udp');
                                  if (clientSocket == null) {
                                    sendUdp();
                                    startTimer();
                                    is_connected = true;
                                    print('after send udp');
                                    _button_text = 'در حال اتصال';
                                    _button_connecting = Colors.green;
                                    setState(() {
                                      _button_text;
                                      _button_connecting;
                                    });
                                  } else {
                                    disconnectClient(false);
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                '${_button_text}',
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
                              child: Switch(
                                value: isEnought,
                                onChanged: (bool value) {
                                  print('before send udp');
                                    setState(() {
                                      isEnought=!isEnought;
                                    //  fmodel!.water_status=isEnought;

                                    });

                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'میزان آب',
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
                          child: Switch(
                            value: isEnoughtFertilizer,
                            onChanged: (bool value) {

                              setState(() {
                                isEnoughtFertilizer=!isEnoughtFertilizer;
                              //  fmodel!.fertilize_status=isEnoughtFertilizer;
                              });

                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'میزان کود',
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
                                  child: LampWidget(
                                    itsOn: light,
                                    switchCenter: false,
                                    switchButton: lightSwitch,
                                    onTap: () {
                                      light=!light;
                                      sendLight();

                                      // fmodel!.light_status=! fmodel!.light_status;
                                     setState(() {

                                     });

                                    },
                                    iconAsset: 'assets/icons/svg/light.svg',
                                    device: 'لامپ',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'لامپ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                  // Step 3.
                                  value: lightDropdownValue,
                                  // Step 4.
                                  items: <String>[
                                    'انتخاب کنید',
                                    'هر 9 ساعت',
                                    'هر 12 ساعت',
                                    'هر 15 ساعت',
                                    'هر 18 ساعت'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    );
                                  }).toList(),
                                  // Step 5.
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      if (is_connected)
                                        lightDropdownValue = newValue!;
                                      if (newValue == 'هر ۹ ساعت') {
                                        sendMessage('LightSchedule:9h');
                                      } else if (newValue == 'هر ۱۲ ساعت') {
                                        sendMessage('LightSchedule:12h');
                                      } else if (newValue == 'هر ۱۵ ساعت') {
                                        sendMessage('LightSchedule:15h');
                                      } else if (newValue == 'هر ۱۸ ساعت') {
                                        sendMessage('LightSchedule:18h');
                                      } else {
                                        sendMessage('LightSchedule:OFF');
                                      }
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'میزان روشن بودن در هر روز',
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
                                  child: PumpWidget(
                                    itsOn: fmodel!.pump_status,
                                    switchCenter: false,
                                    switchButton: lightSwitch,
                                    onTap: () {
                                      fmodel!.pump_status=!fmodel!.pump_status;
                                      sendPump();
                                    },
                                    iconAsset: 'assets/icons/svg/fan.svg',
                                    device: 'پمپ',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'پمپ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                  // Step 3.
                                  value: pumpDropdownValue,
                                  // Step 4.
                                  items: <String>[
                                    'انتخاب کنید',
                                    'هر 15 دقیقه',
                                    'هر 20 دقیقه',
                                    'هر 30 دقیقه'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    );
                                  }).toList(),
                                  // Step 5.
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      if (is_connected)
                                        pumpDropdownValue = newValue!;
                                      if (newValue == 'هر 15 دقیقه') {
                                        sendMessage('PumpSchedule:15m');
                                      } else if (newValue == 'هر 20 دقیقه') {
                                        sendMessage('PumpSchedule:20m');
                                      } else if (newValue == 'هر 30 دقیقه') {
                                        sendMessage('PumpSchedule:30');
                                      } else {
                                        sendMessage('PumpSchedule:OFF');
                                      }
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'میزان روشن بودن در هر ساعت',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(child:
                      GestureDetector(
                          child:
                      Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [
                          Colors.green,
                          Colors.green,
                        ])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('ثبت',style: TextStyle(color: Colors.white,fontSize: 14),),

                      ],
                    ),
                  ),onTap: (){
                        updateGarden();
                      }),
                  ),
  ],
))
                    ],


              ))),
    );
  }

  void lightSwitch() {}

  void sendLight() {
    String cmd = '';
    if (clientSocket != null) {
      if (light) {
        cmd = 'LightOFF\r\n';
        _light_text_button = "لامپ : خاموش";
        _light_color_button = Colors.red;
      } else {
        cmd = 'LightON\r\n';
        _light_color_button = Colors.green;
        _light_text_button = "لامپ : روشن";
      }
      clientSocket!.write('${cmd}');
      setState(() {
        _light_text_button;
        _light_color_button;
      });
      print('send light');
    } else {
      Fluttertoast.showToast(
        msg: "عدم اتصال به گلدان",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void sendPump() {
    String cmd = '';
    if (clientSocket != null) {
      if (pump) {
        cmd = 'PumpOFF\r\n';
        _pump_text_button = "پمپ : خاموش";
        _pump_color_button = Colors.red;
      } else {
        cmd = 'PumpON\r\n';
        _pump_text_button = "پمپ : روشن";
        _pump_color_button = Colors.green;
      }
      clientSocket!.write('${cmd}');
      setState(() {
        _pump_text_button;
        _pump_color_button;
      });
    } else {
      Fluttertoast.showToast(
        msg: "عدم اتصال به گلدان",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void sendStartSchedule() {
    String cmd = '';
    if (clientSocket != null) {
      cmd = 'StartSchedule\r\n';
      clientSocket!.write('${cmd}');
      setNotification();
    } else {
      Fluttertoast.showToast(
        msg: "عدم اتصال به گلدان",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void sendEndSchedule() {
    String cmd = '';
    if (clientSocket != null) {
      cmd = 'EndSchedule\r\n';
      clientSocket!.write('${cmd}');
      cancelNotification();
    } else {
      Fluttertoast.showToast(
        msg: "عدم اتصال به گلدان",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void sendMessage(String message) {
    String cmd = '';
    print('${message}');
    if (clientSocket != null) {
      cmd = '${message}\r\n';
      clientSocket!.write('${cmd}');
    } else {
      Fluttertoast.showToast(
        msg: "عدم اتصال به گلدان",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Widget getFirstWidget(bool isChange) {
    if (isFirst) {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [
                Colors.lightGreen.shade100,
                Colors.lightGreen.shade100,
              ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Image.asset(
                  "assets/images/orange_garden.png",
                  width: 64,
                  height: 64,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'افزودن گل و گیاه',
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.add_box_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 16,
                  )
                ],
              )
            ],
          ),
        ),
        onTap: () {
          if (is_connected) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPlantsScreen()),
            ).then((value) async {
              plants.add(value);
              print('hello');
            //  savePlant();
              setState(() {});
              if (Constant.IS_SET_SETTINGS == true) {
                if (clientSocket != null) {
                  String cmd =
                      'LightNormal,PumpNormal,${Constant.OPTION_SETTINGS}\r\n';
                  clientSocket!.write('${cmd}');
                }
                Constant.IS_SET_SETTINGS = false;
              }
            });
          } else {
            Fluttertoast.showToast(
              msg: "عدم اتصال به گلدان",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
      );
    } else {
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(colors: [
                Colors.lightGreen.shade100,
                Colors.lightGreen.shade100,
              ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          ListView.builder(
          itemCount:userplantList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {

getFlower1("assets/images/tare.png");
              })
            //  getFlower1(flower1),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Text(
            //         'افزودن گل و گیاه',
            //         style: TextStyle(color: Colors.green),
            //       ),
            //       SizedBox(
            //         width: 4,
            //       ),
            //       Icon(
            //         Icons.add_box_outlined,
            //         color: Colors.green,
            //       ),
            //       SizedBox(
            //         width: 4,
            //       )
            //     ],
            //   )
            ],
          ),
        ),
        onTap: () {
          if (is_connected) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPlantsScreen()),
            ).then((value) async {
              plants.add(value);
             // savePlant();
              setState(() {});
              if (Constant.IS_SET_SETTINGS == true) {
                if (clientSocket != null) {
                  String cmd =
                      'LightNormal,PumpNormal,${Constant.OPTION_SETTINGS}\r\n';
                  clientSocket!.write('${cmd}');
                }
                Constant.IS_SET_SETTINGS = false;
              }
            });
          } else {
            Fluttertoast.showToast(
              msg: "عدم اتصال به گلدان",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
      );
    }
  }

  Future<void> savePlant() async {
    isFirst = false;
    String key = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('FLOWER1') == null ||
        preferences.getString('FLOWER1') == '') {
      key = 'FLOWER1';
      print('key = FLOWER1');
    } else {
      Fluttertoast.showToast(
          msg: "ظرفیت گلدان تکمیل می باشد!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    if (Constant.OPTION_SETTINGS == 'Option1') {
      preferences.setString(key, Constant.plantList[0].image);
      if (key == 'FLOWER1') {
        flower1 = Constant.plantList[0].image;
      }
    } else if (Constant.OPTION_SETTINGS == 'Option2') {
      preferences.setString(key, Constant.plantList[1].image);
      if (key == 'FLOWER1') {
        flower1 = Constant.plantList[1].image;
      }
    }
    print(flower1);
    setState(() {});
  }

  @override
  void didChangeDependencies() {}

  Future<void> deletePlant() async {
    isFirst = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('FLOWER1', '');
    preferences.commit();
    setState(() {});
  }

  Widget getFlower1(String flower1) {
 //   if (flower1 != '') {
    if (true) {
      return Padding(
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
        child: GestureDetector(
          child:
          Image.asset(
            flower1,
            width: 64,
            height: 64,
          ),
          onTap: () {
            if(is_connected){
            showPlantDialog();
            }else{
              Fluttertoast.showToast(
                msg: "عدم اتصال به گلدان",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getFlower2(String flower2) {
    if (flower2 != '') {
      return Padding(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Image.asset(
          flower2,
          width: 64,
          height: 64,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getFlower3(String flower3) {
    if (flower3 != '') {
      return Padding(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Image.asset(
          flower3,
          width: 64,
          height: 64,
        ),
      );
    } else {
      return Container();
    }
  }

  void showPlantDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'مدیریت گیاه',
              textDirection: TextDirection.rtl,
            ),
            content: Text(
              'جهت شروع دوره کاشت گیاه خود میتوانید با لمس گزینه شروع کاشت آغاز نمائید. همچنین جهت پایان دادن به زمان کاشت و حذف گیاه موردنظر میتوانید گزینه حذف گیاه را لمس نمائید.',
              textDirection: TextDirection.rtl,
            ),
            actions: [
              new TextButton(
                // textColor: Colors.red,
                child: new Text(
                  'حذف گیاه',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  deletePlant();
                  sendEndSchedule();
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                // textColor: Color.fromRGBO(143, 148, 251, 1),
                child: new Text(
                  'شروع دوره کاشت',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  sendStartSchedule();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
