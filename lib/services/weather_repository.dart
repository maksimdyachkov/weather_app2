
import 'package:weather_app2/models/weather.dart';
import 'package:weather_app2/services/weather_api.dart';

class WeatherRepository {
  WeatherService weatherService = WeatherService();


  Future<Weather> fetchHourlyWeather({ String city, String lat = "", String lon = ""}) {
    return weatherService.fetchHourlyWeather( city: city,lat: lat,lon: lon);
  }
}