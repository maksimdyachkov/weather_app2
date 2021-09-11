import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app2/models/weather.dart';


class WeatherService {
  String _apiKey = "8b1200551cc2a88216763d54a67d3b3f";

   Future<Weather> fetchHourlyWeather({String city, String lat = "", String lon =""}) async {
    var url =
    'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=current,minutely&units=metric&appid=$_apiKey';
   // 'https://api.openweathermap.org/data/2.5/forecast/hourly?q=$city&lat=$lat&lon=$lon&cnt=4&appid=$_apiKey';

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Weather.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}

