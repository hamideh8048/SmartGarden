import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {

  String baseURL = "https://greenchal.ir/";
  Future register(String name ,String phone,String pass) async {
    final data = {
      "full_name" : name,//name,
      "phone_number" : phone,
      "password" : pass,
      "confirm_password" : pass,
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/accounts/register/');

    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future login(String phone ,String pass) async {
    final data = {

      "phone_number" : phone,
      "password" : pass,

    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/accounts/login/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future loginotp(String phone ) async {
    final data = {
      "phone_number" : phone,
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/accounts/login-with-otp/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",},
        body: jsonProduct
    );
   // var responseBody = json.decode(utf8.decode(response.bodyBytes));
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future resetPasswordLoginotp(String phone ) async {
    final data = {
      "phone_number" : phone,
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/accounts/password-reset-validate-otp/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",},
        body: jsonProduct
    );
    // var responseBody = json.decode(utf8.decode(response.bodyBytes));
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future validateOtp(String phone ,String otp) async {
    final data = {
      "phone_number" : phone,
      "otp":otp
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/accounts/validate-otp/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",},
        body: jsonProduct
    );
    // var responseBody = json.decode(utf8.decode(response.bodyBytes));
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future resetPassValidateOtp(String phone,String otp ) async {
    final data = {
      "phone_number" : phone,
      "otp":otp
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/accounts/password-reset-validate-otp/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",},
        body: jsonProduct
    );
    // var responseBody = json.decode(utf8.decode(response.bodyBytes));
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future resetPass(String phone ) async {
    final data = {
      "phone_number" : phone,
    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/accounts/password-reset/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json",},
        body: jsonProduct
    );
    // var responseBody = json.decode(utf8.decode(response.bodyBytes));
    // send to your
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future registerUpdateFlowerpot(String token,String serialno ,bool fertilizer_status,bool light_status,bool pump_status,bool water_status,String pump_interval_minutes,String light_hours,List<String> plants,String name) async {
    final data = {
      "name":name,
      "serial_number" : serialno,
       "fertilizer_status" : fertilizer_status,
      "light_status" : light_status,
      "pump_status" : pump_status,
       "water_status":water_status,
      "fertilizer_status":fertilizer_status,
      "pump_interval_minutes":pump_interval_minutes,
      "light_hours":light_hours,
      "plants":plants
   };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/plants/register-update-flowerpot/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json", 'Authorization': 'Token $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
   // var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future registerUpdateFlowerpotfertilize(String token,String serialno ,bool fertilizer_status,bool light_status,bool pump_status,bool water_status,String pump_interval_minutes,String light_hours,List<String> plants) async {
    final data = {

      "serial_number" : serialno,
      "fertilizer_status" : fertilizer_status,
      "light_status" : light_status,
      "pump_status" : pump_status,
      "water_status":water_status,
      "fertilizer_status":fertilizer_status,
      "pump_interval_minutes":pump_interval_minutes,
      "light_hours":light_hours,
      "plants":plants,
      "last_fertilization_time":DateTime.now().toString()

    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/plants/register-update-flowerpot/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json", 'Authorization': 'Token $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    //var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future registerFlowerpot(String token) async {
    final data = {

      "serial_number" : "32",

    };
    final String jsonProduct = json.encode(data);
    final uri=  Uri.parse( 'https://greenchal.ir/plants/register-update-flowerpot/');
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json", 'Authorization': 'Token $token',},
        body: jsonProduct
    );
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  Future getUserFlowers(String token) async {
    //https://smartgarden.chbk.run/plants/register-flowerpot/
 //   https://smartgarden.chbk.run/plants/flowerpot-status/1/
    final uri=  Uri.parse( 'https://greenchal.ir/plants/user-flowerpots/');

    //[[[[
    var response = await http.get(uri,
        headers: {"Content-Type": "application/json",  'Authorization': 'Token $token',},

    );
    // var responseBody = json.decode(response.body);
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    return responseBody;
  }
  Future getPlants(String token) async {
    //https://smartgarden.chbk.run/plants/register-flowerpot/
    //   https://smartgarden.chbk.run/plants/flowerpot-status/1/
    final uri=  Uri.parse( 'https://greenchal.ir/plants/plant/');

    var response = await http.get(uri,
      headers: {"Content-Type": "application/json",     'Accept': 'application/json', 'Authorization': 'Token $token',},

    );
   // String reply = await response.transform(utf8.decoder).join();
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    return responseBody;
  }
}

