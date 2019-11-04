import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import "../services/api.dart";
import "../models/wateringperiod.dart";
import "wateringperiodeditor.dart";

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  int _buttonPress = 0;
  var wateringPeriods = new List<WateringPeriod>();
  _getWateringPeriods() {
      API.getWateringPeriods().then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          wateringPeriods = list.map((model) => WateringPeriod.fromJson(model)).toList();
        });
      });
    }

  initState() {
      super.initState();

      _getWateringPeriods();
    }

  Widget _listItemBuilder(BuildContext context, int index)
  {
    return ListTile 
    (
      title: Text(new DateFormat('dd.M  kk:mm').format(wateringPeriods[index].date)),
      subtitle: Text( "Duration: " + wateringPeriods[index].duration.toString()),
      onTap:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WateringPeriodEditor(wateringPeriod:wateringPeriods[index])), 
                    );
                  },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[   
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WateringPeriodEditor(wateringPeriod:wateringPeriods[0])), 
                    );
                  },
                  child:Text("Edit Watering")
               ),
               FlatButton(
                onPressed: () {
                    DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2019, 11, 2),
                      maxTime: DateTime(2019, 11, 9),
                      onChanged: (date) {print('change $date');},
                      onConfirm: (date) {print('confirm $date');},
                      currentTime: DateTime.now(), locale: LocaleType.de);},
                    child: Text('Show DateTime Picker',)
                  ),
                  Expanded(
                    child:ListView.builder(
                    itemCount:wateringPeriods.length,

                      itemBuilder: _listItemBuilder
                      )
                  )
            ]
          ),
        )
      );
  }
}