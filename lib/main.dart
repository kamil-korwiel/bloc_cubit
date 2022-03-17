
import 'package:bloc_cubit/cubit/weather_cubit.dart';
import 'package:bloc_cubit/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherCubit(FakeWeatherRepository()),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {

            if (state is WeatherInitial){
              return const Text("Push Button");
            } else if (state is WeatherLoading){
              return const CircularProgressIndicator();
            } else if (state is WeatherLoaded){
              return Text("In City ${state.weather.cityName} is right now ${state.weather.temperatureCelsius} \u2103",
              overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 17.0),);
            } else if (state is WeatherError){
              return Text(state.message);
            }else {
              return const Text('null');
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          BlocProvider.of<WeatherCubit>(context).getWeather();
        },
        tooltip: 'New request',
        child: const Icon(Icons.refresh_sharp),
        )
    );
  }
}
