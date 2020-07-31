import 'package:flutterapp/models/weather.dart';

class Forecast{
  String temp;
  String timeStamp;
  Weather weather;
  String windCdir;
  String pressure;
  String ozone;
  String windSpeed;


  Forecast({this.temp, this.timeStamp, this.weather, this.windCdir,
      this.pressure, this.ozone, this.windSpeed});

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
      temp: json['temp'].toString(),
      timeStamp: json['datetime'],
      weather: Weather.fromJson(json['weather']),
      windCdir: json['wind_cdir'],
      pressure: json['pres'].toString(),
      ozone: json['ozone'].toString(),
        windSpeed: json['wind_spd'].toString()
    );
  }
}