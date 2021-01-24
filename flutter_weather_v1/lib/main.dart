import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_bloc.dart';
import 'package:flutterweatherv1/blocs/theme/theme_bloc.dart';
import 'package:flutterweatherv1/blocs/weather/weather_bloc.dart';
import 'package:flutterweatherv1/blocs/weather/weather_bloc_observer.dart';
import 'package:flutterweatherv1/constants/data_constants.dart';
import 'package:flutterweatherv1/repositories/weather_repository.dart';
import 'package:flutterweatherv1/screens/weather_screen.dart';
import 'package:http/http.dart' as http;

import 'blocs/theme/theme_state.dart';

void main() {
  BlocSupervisor.delegate = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());

//  runApp(BlocProvider<ThemeBloc>(
//    create: (context) => ThemeBloc(),
//    child: BlocProvider<SettingBloc>(
//      create: (context) => SettingBloc(),
//      child: MyApp(
//        weatherRepository: weatherRepository,
//      ),
//    ),
//  ));

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider<SettingBloc>(
        create: (context) => SettingBloc(),
      ),
      BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
      ),
    ],
    child: MyApp(weatherRepository: weatherRepository),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
            title: 'Flutter ${DataConstants.AppNameUI}',
            debugShowCheckedModeBanner: false,
            home: WeatherScreen());
      },
    );
  }
}

//BlocProvider(
//create: (context) =>
//WeatherBloc(weatherRepository: weatherRepository),
//child: WeatherScreen(),
//)
