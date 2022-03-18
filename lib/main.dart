
import 'package:bloc_cubit/bloc/weather_bloc.dart';
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
        create: (context) => WeatherBloc(FakeWeatherRepository()),
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
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {

            if (state is WeatherInitial){
              return const Text("Push Button");
            } else if (state is WeatherLoading){
              return const SizedBox(child: CircularProgressIndicator(),height: 100.0,width: 100.0,);
            } else if (state is WeatherLoaded){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("In City ' ${state.weather.cityName} ' is right now ${state.weather.temperatureCelsius.toStringAsFixed(2)} \u2103",
                overflow: TextOverflow.visible,
                style: const TextStyle(fontSize: 25.0),
                textAlign: TextAlign.center,),
              );
            } else if (state is WeatherError){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(state.message,
                overflow: TextOverflow.visible,
                style: const TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,),
              );
            }else {
              return const Text('null');
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          BlocProvider.of<WeatherBloc>(context).add(GetWetherEvent());
        },
        tooltip: 'New request',
        child: const Icon(Icons.refresh_sharp),
        )
    );
  }
}
