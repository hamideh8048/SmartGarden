
class FlowerModel{
  String id = "";
  String name = "";
  String serial_number = "";
  String water_level = "";
  String last_watering_time = "";
  String change_water_time = "";
  String warranty_activation_time = "";
  bool warranty_status = false;
  bool water_status = false;
  bool fertilize_status = false;
  bool light_status = false;
  String light_hours = "";
  bool pump_status = false;
  String main_user = "";
  String last_fertilization_time  = "";
  String description="";
  List<String> other_users=[];
  List<String> plants=[];
  String pump_interval_minutes = "";

  FlowerModel.fromJson(Map<String, dynamic> parsedJson){
    id =parsedJson["id"].toString() ??  "";
    name =parsedJson["name"] ??  "";

    serial_number =parsedJson["serial_number"] ??  "";
    water_level =parsedJson["water_level"]==null ?  "":parsedJson["water_level"].toString();
    last_fertilization_time =parsedJson["last_fertilization_time"]==null ?  "":parsedJson["last_fertilization_time"].toString();
    last_watering_time =parsedJson["last_watering_time"] ??  "";
    change_water_time =parsedJson["change_water_time"] ??  "";
    warranty_activation_time =parsedJson["warranty_activation_time"] ??  "";
    warranty_status =parsedJson["warranty_status"] ??  false;
    light_status=parsedJson["light_status"] ?? false;
    fertilize_status=parsedJson["fertilize_status"] ?? false;
    water_status=parsedJson["water_status"] ?? false;
    light_hours  =parsedJson["light_hours"].toString() ??  "";
    pump_status  =parsedJson["pump_status"] ?? false;
    pump_interval_minutes  =parsedJson["pump_interval_minutes"].toString() ??  "";
    last_fertilization_time  =parsedJson["last_fertilization_time"] ??  "";
    main_user=parsedJson["main_user"] .toString()??  "";
    if (parsedJson['plants'] != null) {
    //  var options = <Option>[];
      List<String> Options=[];

      for (var option in (parsedJson['plants'] as List) ){
        Options.add(option.toString());
      }
      plants = Options;
    }
  String a="";
  }

}