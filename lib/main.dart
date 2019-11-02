import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import "services/api.dart";

void main() => runApp(MyApp());
const baseUrl = "https://happyrobogarden.herokuapp.com";

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



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'doodle jump'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    var date = new DateFormat.yMMMd().format(wateringPeriods[index].date);
    return Text(date,style:Theme.of(context).textTheme.headline);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[   
             FlatButton(
              onPressed: () {
                  DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2022, 12, 31),
                    onChanged: (date) {print('change $date');},
                    onConfirm: (date) {print('confirm $date');},
                    currentTime: DateTime.now(), locale: LocaleType.en);},
                  child: Text('Show DateTime Picker',)
                ),
                Expanded(
                  child:ListView.builder(
                  itemCount:wateringPeriods.length,
                    itemExtent:30,
                    itemBuilder: _listItemBuilder
                    )
                )
          ]
        )
      );
  }
}
