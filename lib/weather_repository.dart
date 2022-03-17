import 'dart:math';

import 'package:bloc_cubit/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(const Duration(seconds: 1),(){
      final random = Random();
      if(random.nextBool()){
        throw Exception("Some thing go wrong");
      }
      return Weather(cityName: cityName, 
      temperatureCelsius: 20 + random.nextInt(15) + random.nextDouble());
    });
  }

}