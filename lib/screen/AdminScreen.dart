import 'package:flutter/material.dart';
import 'package:udp/udp.dart';
import 'dart:io';
import 'dart:convert';

class AdminScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdminScreenState();
  }
}

class AdminScreenState extends State<AdminScreen> {

  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  ServerSocket? serverSocket;
  Socket? clientSocket;
  int port = 4310;
  String _log = 'Log ...';
  String _cmd_ok = 'ok,\r\n';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startServer();
  }

  Future<void> sendUdp() async {
    print('Send UDP :)');

    var sender = await UDP.bind(Endpoint.broadcast(port: Port(4210)));

    // send a simple string to a broadcast endpoint on port 2390.
    var dataLength =
        await sender.send("ok".codeUnits, Endpoint.broadcast(port: Port(4210)));

    stdout.write("$dataLength bytes sent.");

    // creates a new UDP instance and binds it to the local address and the port
    // 65002.
    var receiver = await UDP.bind(Endpoint.broadcast(port: Port(4210)));

    // receiving\listening
    receiver.asStream(timeout: Duration(seconds: 2)).listen((datagram) {
      var str = String.fromCharCodes(datagram!.data);
      stdout.write(str);
    });

    // close the UDP instances and their sockets.
    sender.close();
    receiver.close();
  }

  Future<void> sendLocalUdp(String ip) async {
    print('Send Local UDP to ${ip}');

    InternetAddress destination = InternetAddress('192.168.1.255');
    RawDatagramSocket udp =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, 4310);
    List<int> message = utf8.encode('ok');
    udp.broadcastEnabled = true;
    udp.send(message, destination, 4310);
    await Future.delayed(Duration(seconds: 3));
    udp.close();
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

        clientSocket!.write('${_cmd_ok}');
        _log = _log + '\n' +'Garden: '+ String.fromCharCodes(onData).trim();
        setState(() {
          _log;
        });
      },
      onError: (e) {
        disconnectClient();
      },
      onDone: () {
        disconnectClient();
      },
    );
  }

  void stopServer() {
    disconnectClient();
    serverSocket!.close();
  }

  void disconnectClient() {
    if (clientSocket != null) {
      clientSocket!.close();
      clientSocket!.destroy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'پنل مدیریت',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Container(
        child: Padding(padding: EdgeInsets.all(32),
        child: Column(
          children: [

            Center(
              child: new GestureDetector(
                onTap: () {
                  sendUdp();
                },
                child: Container(
                  height: 50,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: [
                        Colors.lightGreen,
                        Colors.lightGreen,
                      ])),
                  child: Center(
                      child: Text(
                        "Send UDP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            SizedBox(height: 40,),

            Center(
              child:Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[100]!))),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Command',
                      hintText: "Type a command...",
                      hintTextDirection: TextDirection.ltr,
                      hintStyle:
                      TextStyle(color: Colors.grey[400])),
                ),
              ),
            ),

            SizedBox(height: 12,),

            Center(
              child: new GestureDetector(
                onTap: () {
                  String cmd = controller.text + '\r\n';
                  clientSocket!.write('${cmd}');
                  _log = _log + '\n' + 'App: '+controller.text;
                  setState(() {
                    _log;
                  });
                },
                child: Container(
                  height: 44,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: [
                        Colors.blue,
                        Colors.blue,
                      ])),
                  child: Center(
                      child: Text(
                        "Send command",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),

            SizedBox(height: 24,),


            Text(_log),


          ],
        ),),
      ),
    );
  }
}
