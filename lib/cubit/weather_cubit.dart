


import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app2/cubit/weather_state.dart';
import 'package:weather_app2/models/weather.dart';
import 'package:weather_app2/services/weather_repository.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  final WeatherRepository _weatherRepository;


  WeatherCubit(this._weatherRepository) : super(WeatherState());

   String get strFormat => state.weather.isDaily ? "dd/MM/yyyy, HH:mm a" : "HH:mm a";
   bool isHowAlert = false;


  void handleClick(String value) {
    switch (value) {
      case 'Дни':
        emit(state.copyWith(weather: state.weather.copyWith(isDaily: false)));
        break;
      case 'Часы':
        emit(state.copyWith(weather: state.weather.copyWith(isDaily: true)));
        break;
      case 'Hours':
       emit(state.copyWith(weather: state.weather.copyWith(isDaily: false)));
        break;
      case 'Daily':
        emit(state.copyWith(weather: state.weather.copyWith(isDaily: true)));
        break;
    }
  }

  Future<Weather> fetchWeather(
      {String city = "", String lat = "", String lon = ""}) async {
    try{
      emit(state.copyWith(status: WeatherStatus.loading));
     Weather weatherResp = await _weatherRepository.fetchHourlyWeather(city: city, lat: lat, lon: lon);
      emit(state.copyWith(status: WeatherStatus.success,weather: weatherResp));
      return weatherResp;
    } catch (_) {
      emit(state.copyWith(weather: Weather.empty, status: WeatherStatus.failure));
      return Weather.empty;
    }
  }



  Future<Position> tryAgainDeterminePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        fetchWeather(lat: "50,27",lon: "30,31",);
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      fetchWeather(lat: "50,27",lon: "30,31",);
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void tryAfainGetCurrentWeatherWithPosition() async{
    var location = await tryAgainDeterminePosition();
    if(location == null) {

    } else {
      fetchWeather(lon: location.longitude.toString(),lat: location.latitude.toString(),city: "");
    }

  }



  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;



    // сall position determination only if weather data has not been received yet
    if(state.weather != Weather.empty) {
      isHowAlert = true;
      return Future.error('There is already data in the store');
    } else isHowAlert = false;


    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        fetchWeather(lat: "50,27",lon: "30,31",);
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      fetchWeather(lat: "50,27",lon: "30,31",);
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentWeatherWithPosition() async{
    var location = await determinePosition();
    if(location == null) {

    } else {
      fetchWeather(lon: location.longitude.toString(),lat: location.latitude.toString(),city: "");
    }

  }


  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    try{

      return WeatherState.fromMap(json);
     // return null;
    }catch(_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    try{
      return state.toMap(state);
     // return null;
    }
    catch(_) {
      return null;
    }
  }
}

