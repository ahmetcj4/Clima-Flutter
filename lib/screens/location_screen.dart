import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final data;
  LocationScreen({this.data});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final weather = WeatherModel();
  var temperature;
  var condition;
  var message;
  @override
  void initState() {
    super.initState();
    updateUi(widget.data);
  }

  void updateUi(dynamic weatherData) => setState(() {
        if (weatherData == null) {
          temperature = 0;
          condition = 1000;
          message = 'Unable to get weather data';
        } else {
          temperature =
              (double.tryParse(weatherData['main']['temp'].toString()) ?? 0.0)
                  .round();
          condition = weatherData['weather'][0]['id'];
          message =
              "${weather.getMessage(temperature)} in ${weatherData['name']}!";
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async =>
                        updateUi(await weather.getLocationWeather()),
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      final cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => CityScreen()),
                      );
                      if (cityName != null) {
                        updateUi(await weather.getCityWeather(cityName));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weather.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  message,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
