import 'package:flutter/material.dart';

class AddNewGardenWithDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddNewGardenWithDetailsScreenState();
  }

}

class AddNewGardenWithDetailsScreenState extends State<AddNewGardenWithDetailsScreen>{


  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text('جزئیات گلدان جدید',style: TextStyle(fontSize: 16,color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.orange,
            ),
            onPressed: () {

            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(24),child: Text('افزودن گلدان هوشمند مدل ۱',style: TextStyle(color: Colors.brown,fontSize: 24),),),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Colors.lightGreen.shade100,
                    Colors.lightGreen.shade100,
                  ])),
              child: Image.asset("assets/images/smart_garden_2.png"),
            ),
            SizedBox(
              height: 44,
            ),
            Container(
              margin: EdgeInsets.only(right: 16,left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'نام گلدان',
                    style: TextStyle(),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 8,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        hintText: 'نام گلدان خود را وارد نمائید',
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
              margin: EdgeInsets.only(right: 16,left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'مکان گلدان',
                    style: TextStyle(),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 8,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        hintText: 'مکان گلدان ورود خود را وارد نمائید',
                        hintTextDirection: TextDirection.rtl
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

}