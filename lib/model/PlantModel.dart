
class PlantModel{
  String id = "";
  String name = "";
  String description = "";
  String url="";
  String category="";
  String germination_time="";
  String best_growing_temperature="";
  String required_light_hours="";
  String do_you_know="";
  String harvest_time="";

  PlantModel.fromJson(Map<String, dynamic> parsedJson){
    id =parsedJson["id"].toString() ??  "";
    name =parsedJson["name"] ??  "";
    url =parsedJson["picture"] ??  "";
    do_you_know =parsedJson["do_you_know"] ??  "";
    description =parsedJson["description"] ??  "";
    category =parsedJson["category"]==null ?  "":parsedJson["category"].toString();
    harvest_time =parsedJson["harvest_time"]==null ?  "":parsedJson["harvest_time"].toString();
    germination_time =parsedJson["germination_time"]==null ?  "":parsedJson["germination_time"].toString();
    best_growing_temperature =parsedJson["best_growing_temperature"] ==null?  "":parsedJson["best_growing_temperature"].toString();
    required_light_hours =parsedJson["required_light_hours"]==null  ?  "":parsedJson["required_light_hours"].toString();
  }

}