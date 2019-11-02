import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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