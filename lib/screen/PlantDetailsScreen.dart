import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:samrt_garden/model/PlantModel.dart';
import 'package:samrt_garden/utils/Constant.dart';

class PlantDetailsScreen extends StatefulWidget{
  const PlantDetailsScreen({Key? key, this.plantModel}) : super(key: key);

  final  PlantModel? plantModel;
  @override
  State<StatefulWidget> createState() {
    return PlantDetailsScreenState();
  }

}

class PlantDetailsScreenState extends State<PlantDetailsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('پروفایل گیاه',style: TextStyle(color: Colors.black,fontSize: 16),),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.orange),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 16,),
          Center(
            child: Text(widget.plantModel!.name,style: TextStyle(color: Colors.brown,fontSize: 24),),
          ),
          SizedBox(height: 16,),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.lightGreen.shade100,
                  Colors.lightGreen.shade100,
                ])),
            child:
            CachedNetworkImage(
              height: 60,
              width: 60,
              imageUrl:widget.plantModel!.url,
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
            //   "assets/images/baby_esfenaj.png",
            //   height: 100,
            //   width: 100,
            // ),
          ),
          Padding(padding: EdgeInsets.all(16),
            child:Text(widget.plantModel!.description,style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,),),
          SizedBox(height: 16,),
          Padding(padding: EdgeInsets.all(16),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('نکات مهم درباره گیاه :',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,textAlign: TextAlign.end)],
            ),),
          Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('دسته گیاه : ${widget.plantModel!.category}',style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,),
                SizedBox(width: 4,),
                Image.asset("assets/icons/vector.png"),
              ],
            ),),
          Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('جوانه زنی : ${widget.plantModel!.germination_time}',style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,),
                SizedBox(width: 4,),
                Image.asset("assets/icons/vector.png"),
              ],
            ),),
          Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('برداشت در ${widget.plantModel!.harvest_time} روز ',style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,),
                SizedBox(width: 4,),
                Image.asset("assets/icons/vector.png"),
              ],
            ),),
          Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('بهترین دمای رشد : ${widget.plantModel!.best_growing_temperature} درجه سانتیگراد ',style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,),
                SizedBox(width: 4,),
                Image.asset("assets/icons/vector.png"),
              ],
            ),),
          Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('نوردهی مناسب : ${widget.plantModel!.required_light_hours} ساعت ',style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,),
                SizedBox(width: 4,),
                Image.asset("assets/icons/vector.png"),
              ],
            ),),

          Padding(padding: EdgeInsets.all(16),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('آیا میدونستید...',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,textAlign: TextAlign.end)],
            ),),
          Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.8 ,child:
                Text(' ${widget.plantModel!.do_you_know}',style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,)),
                SizedBox(width: 4,),
                Image.asset("assets/icons/vector.png"),
              ],
            ),),
          // Padding(padding: EdgeInsets.only(right: 16,left: 16,bottom: 8),
          //   child:Text('${Constant.plantList[0].question}',style: TextStyle(color: Colors.black,fontSize: 14),textDirection: TextDirection.rtl,textAlign: TextAlign.right,textWidthBasis: TextWidthBasis.longestLine,),),

        ],
      )
    );
  }

}
