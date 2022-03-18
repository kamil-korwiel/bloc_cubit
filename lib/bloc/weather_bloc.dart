
import 'package:bloc/bloc.dart';
import 'package:bloc_cubit/weather_model.dart';
import 'package:bloc_cubit/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  
  WeatherBloc(
    this._weatherRepository,
  ) : super(WeatherInitial()) {
    on<GetWetherEvent>((event, emit) async {
      try{
        emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather("Tor");
        emit(WeatherLoaded(weather));
      }on Exception catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
