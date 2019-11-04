import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import "../services/api.dart";
import "../models/wateringperiod.dart";

class WateringPeriodEditor extends StatefulWidget {
  final WateringPeriod wateringPeriod;

  WateringPeriodEditor({Key key, @required this.wateringPeriod})
      : super(key: key);

  _WateringPeriodEditorState createState() => _WateringPeriodEditorState();
}




class _WateringPeriodEditorState extends State<WateringPeriodEditor> {
  WateringPeriod wateringPeriodEdit;
  int duration;
  DateTime date;

initState() {
  super.initState();
   setState(() {
      duration = widget.wateringPeriod.duration;
      date = widget.wateringPeriod.date;
    });

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Edit watering time"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    new DateFormat('dd.M  kk:mm').format(date),
                    style: Theme.of(context).textTheme.headline),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(duration.toString(),
                    style: Theme.of(context).textTheme.headline),
              ),
              Slider(
                onChanged: (double value) {
                  setState(() {
                    duration = value.toInt();
                  });
                },
                value: duration.toDouble(),
                min: 0,
                max: 120
            
                )
                 ,
              Padding(
            
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
