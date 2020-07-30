import 'package:flutterapp/models/weather.dart';

class Forecast{
  String temp;
  String timeStamp;
  Weather weather;

  Forecast({this.temp, this.timeStamp, this.weather});

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
      temp: json['temp'].toString(),
      timeStamp: json['datetime'],
      weather: Weather.fromJson(json['weather'])
    );
  }
}