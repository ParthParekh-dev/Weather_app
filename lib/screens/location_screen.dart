import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherLocation});

  final weatherLocation;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = new WeatherModel();
  String temp, weatherIcon, name, message;
  String day, fullDate;

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherLocation);
    var date = DateTime.now();

    day = DateFormat('EEEE').format(date);
    fullDate = DateFormat('d MMM yyyy').format(date);

    // print(date.toString()); // prints something like 2019-12-10 10:02:22.287949
    // print(DateFormat('EEEE').format(date)); // prints Tuesday
    // print(DateFormat('EEEE, d MMM, yyyy')
    //     .format(date)); // prints Tuesday, 10 Dec, 2019
    // print(DateFormat('H').format(date)); // prints 10:02 AM
  }

  void updateUI(dynamic decodedJson) {
    setState(() {
      if (decodedJson == null) {
        temp = '';
        name = 'Error';
        message = 'Failed to fetch details';
        return;
      }
      temp = decodedJson['main']['temp'].toString().substring(0, 2);
      var condition = decodedJson['weather'][0]['id'];
      name = decodedJson['name'].toString();
      message = weatherModel.getMessage(int.parse(temp));
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: int.parse(DateFormat('H').format(DateTime.now())) > 12
                  ? kNightTheme
                  : kDayTheme),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      onPressed: () async {
                        updateUI(await weatherModel.getWeatherData());
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var city_name = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (city_name != null) {
                          updateUI(
                              await weatherModel.getCityWeather(city_name));
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      day + '\n' + fullDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Mina-Regular',
                        fontSize: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Text(
                      "$message in \n$name",
                      style: kMessageTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
