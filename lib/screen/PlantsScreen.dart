import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samrt_garden/model/PlantModel.dart';
import 'package:samrt_garden/screen/PlantDetailsScreen.dart';
import 'package:samrt_garden/services/services.dart';
import 'package:samrt_garden/utils/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlantsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlantsScreenState();
  }
}

class PlantsScreenState extends State<PlantsScreen> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getPlant();
  }

  List<PlantModel> plantList = [];
  getPlant() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    if (token != null && token.length > 2) {
      var response = await (Services()).getPlants(token);
      if (response != null && response.length>0) {
        response.forEach((element) {
          plantList.add(PlantModel.fromJson(element));
          //  taradods.add(TaradodListModel.fromJson(element));
        });
      }
      setState(() {

      });
    }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          'فهرست گیاهان',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body:

      Container(
          child: Padding(
              padding: EdgeInsets.all(8),
              child:
              // GridView(
              //   primary: false,
              //   shrinkWrap: true,
              //   padding: EdgeInsets.all(2),
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //   ),
              GridView.count(

                  shrinkWrap: true,
                  crossAxisCount: 2,
                  //physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  children: List.generate(plantList.length, (index) {
                    // children: <Widget>[
                    return   Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(colors: [
                              Colors.lightGreen.shade50.withAlpha(90),
                              Colors.lightGreen.shade50.withAlpha(90),
                            ])),
                        child: GestureDetector(
                          onTap: () {
                            Constant.IS_SET_SETTINGS = true;
                            Constant.OPTION_SETTINGS = "Option1";
                            Navigator.pop(context, plantList[index].id);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //  mainAxisSize: MainAxisSize.max,
                            children: [
                              CachedNetworkImage(
                                height: 60,
                                width: 60,
                                imageUrl: plantList[index].url,
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
                              ),
                              // Image.asset(
                              //   "assets/images/baby_esfenaj.png",
                              //   height: 65,
                              //   width: 65,
                              // ),
                              SizedBox(
                                height: 8,
                              ),
                              Center(child:
                              //  Padding(padding: EdgeInsets.only(left: 16),
                              SizedBox(child:
                              Text(plantList[index].name))),
                              SizedBox(
                                height: 16,
                              ),

                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlantDetailsScreen(plantModel:plantList[index],)),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icons/view_plant.png"),
                                    Text(
                                      'مشاهده پروفایل گیاه',
                                      style: TextStyle(fontSize: 12,color: Colors.brown),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ));}





                  ))))

    );
  }
}
