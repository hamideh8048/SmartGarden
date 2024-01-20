import 'package:flutter/material.dart';
import 'package:samrt_garden/screen/PlantDetailsScreen.dart';
import 'package:samrt_garden/utils/Constant.dart';

class GuideScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuideScreenState();
  }
}

class GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          'راهنما',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می‌باشد.',style: TextStyle(),textDirection: TextDirection.rtl,),
                Padding(padding: EdgeInsets.all(12)),
                Image.asset(
                  "assets/images/sp1.png",
                  height: 200,
                ),
                Padding(padding: EdgeInsets.all(12)),
                Text('لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می‌باشد.',style: TextStyle(),textDirection: TextDirection.rtl,),
                Padding(padding: EdgeInsets.all(12)),
                Image.asset(
                  "assets/images/sp1.png",
                  height: 200,
                ),
                Padding(padding: EdgeInsets.all(12)),
                Text('لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می‌باشد.',style: TextStyle(),textDirection: TextDirection.rtl,),
                Padding(padding: EdgeInsets.all(12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
