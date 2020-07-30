import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/forecast.dart';
import 'package:flutterapp/screens/singin.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Forecast> forecastList;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Center(child: getWeatherForecast()),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget getWeatherForecast() {
    return (forecastList != null)? ListView.builder(
      itemCount: forecastList.length,
      itemBuilder: (context, index) => getForecastItem(forecastList[index]),
    ) : Container();
  }

  Future<bool> willPop() async {
    signOutGoogle();
    return true;
  }

  Future<void> getData() async {
    var data;
    try {
      final result = await http.get(
          'https://api.weatherbit.io/v2.0/forecast/hourly?city=Kalush&key=d5581017379c4a45b68ce6cda924ab92');
      if (result.statusCode == 200) {
        data = json.decode(utf8.decode(result.bodyBytes));
        setState(() {
          forecastList = data['data']
              .map<Forecast>((json) => Forecast.fromJson(json))
              .toList();
        });
      }
    } on Exception catch (_) {}
  }

  Widget getForecastItem(Forecast forecast) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(forecast.timeStamp),
        Text(forecast.weather.description),
        Text(forecast.temp),
      ],
    );
  }
}
