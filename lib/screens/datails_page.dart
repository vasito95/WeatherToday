import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/forecast.dart';

import '../app_localizations.dart';

class DetailsPage extends StatefulWidget {
  Forecast forecast;
  String currentCity;
  DetailsPage(this.forecast, this.currentCity);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          automaticallyImplyLeading: true,
          title: Text(widget.currentCity),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(AppLocalizations.of(context).translate('time') + ' ' +widget.forecast.timeStamp),
              Text(AppLocalizations.of(context).translate('description') + ' ' + widget.forecast.weather.description),
              Text(AppLocalizations.of(context).translate('temp') + ' ' + widget.forecast.temp),
              Text(AppLocalizations.of(context).translate('ozone') + ' ' + widget.forecast.ozone),
              Text(AppLocalizations.of(context).translate('pressure') + ' ' + widget.forecast.pressure),
              Text(AppLocalizations.of(context).translate('wind_direction') + ' ' + widget.forecast.windCdir),
              Text(AppLocalizations.of(context).translate('wind_speed') + ' ' + widget.forecast.windSpeed),
            ],
          ),
        )
      );
  }
}
