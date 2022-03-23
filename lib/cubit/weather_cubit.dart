import 'package:bloc/bloc.dart';
import 'package:bloc_cubit/weather_model.dart';
import 'package:bloc_cubit/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String nameCity) async {
    try{
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(nameCity);
      emit(WeatherLoaded(weather));
    }on Exception catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
