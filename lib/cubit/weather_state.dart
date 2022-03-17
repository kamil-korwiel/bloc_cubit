part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  WeatherLoaded(this.weather);
  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
  @override
  List<Object> get props => [message];
}
