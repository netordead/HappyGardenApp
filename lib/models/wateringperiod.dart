import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import "../services/api.dart";


class WateringPeriod {
  final DateTime date;
  final int duration;

  WateringPeriod({this.date, this.duration});

  factory WateringPeriod.fromJson(Map<String, dynamic> json) {
    WateringPeriod wp = WateringPeriod(
      date: DateTime.parse(json['date']),
      duration: json['duration']
    );
    return wp;
  }


  Map toJson() {
    return {'date': date, 'duration': duration};
  }
}