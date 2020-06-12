import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper {
  static const API_KEY = 'ffdbb955a7aa95f58c030d0298b0fece';
  static const URL = 'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getWeatherData(lat, lon) async {
    try {
      final response =
          await get('$URL?units=metric&lat=$lat&lon=$lon&appid=$API_KEY');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getCityWeatherData(cityName) async {
    try {
      final response =
          await get('$URL?units=metric&q=$cityName&appid=$API_KEY');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
