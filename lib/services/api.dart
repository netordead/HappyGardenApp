import 'package:http/http.dart' as http;
import 'dart:async';

const baseUrl = "https://happyrobogarden.herokuapp.com";
class API {
  static Future getWateringPeriods() {
    var url = baseUrl + "/list";
    return http.get(
        url, 
        headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json'
        }
      );
  }
}