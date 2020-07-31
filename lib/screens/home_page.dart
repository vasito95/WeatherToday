import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/forecast.dart';
import 'package:flutterapp/screens/datails_page.dart';
import 'package:flutterapp/screens/singin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../app_localizations.dart';
import '../database_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Forecast> forecastList;
  String dropdownValue = "daily";
  String currentCity = '';
  String city;
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    initializeUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: AppBar(
          leading: Text(name ?? ''),
          title: Text(currentCity),
          actions: <Widget>[getDropDownButton()],
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your City',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .translate('correct');
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            city = searchController.text;
                            searchController.clear();
                            getData();
                          });
                        },
                        child: Text(
                            AppLocalizations.of(context).translate('search')),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: getWeatherForecast(),
              )
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget getWeatherForecast() {
    return (forecastList != null)
        ? ListView.builder(
            itemCount: forecastList.length,
            itemBuilder: (context, index) => GestureDetector(
                  child: getForecastItem(forecastList[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return DetailsPage(forecastList[index], currentCity);
                      }),
                    );
                  },
                ))
        : Container();
  }

  Future<bool> willPop() async {
    signOutGoogle();
    return true;
  }

  Future<void> getData() async {
    String appLocale = Localizations.localeOf(context).languageCode;
    var data;
    try {
      final result = await http.get(
          'https://api.weatherbit.io/v2.0/forecast/$dropdownValue?city=$city&lang=$appLocale&key=d5581017379c4a45b68ce6cda924ab92');
      if (result.statusCode == 200) {
        Future<Directory> dir =
        data = json.decode(utf8.decode(result.bodyBytes));
        currentCity = data['city_name'];
        setState(() {
          forecastList = data['data']
              .map<Forecast>((json) => Forecast.fromJson(json))
              .toList();
        });
        DatabaseService.updateLastCity(currentCity);
      }
    } on Exception catch (_) {}
  }

  Widget getForecastItem(Forecast forecast) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 60,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(forecast.timeStamp),
            flex: 1,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Image.asset(forecast.weather.icon+'.png'),
                Text(forecast.weather.description),
                Text(forecast.temp)
              ],
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget getDropDownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
      iconSize: 25,
      elevation: 18,
      style: TextStyle(color: Colors.white),
      underline: Container(
        height: 3,
        color: Colors.white,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        getData();
      },
      items: <String>['daily', 'hourly']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value.toLowerCase(),
          child: Text(
            AppLocalizations.of(context).translate(value),
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }

  void initializeUserData() async {
    city = await DatabaseService.getLastCity();
    getData();
  }
}
