import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterweatherv1/models/city.dart';
import 'package:flutterweatherv1/models/weather.dart';
import 'package:flutterweatherv1/models/weatherList.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSearchSuccess extends WeatherState {
  final CityList cityList;
  const WeatherStateSearchSuccess({@required this.cityList})
      : assert(cityList != null);
}

class WeatherStateSuccess extends WeatherState {
  final WeatherList weatherList;
  const WeatherStateSuccess({@required this.weatherList})
      : assert(weatherList != null);
  @override
  // TODO: implement props
  List<Object> get props => [weatherList];
}

class WeatherStateFailure extends WeatherState {
  final String message;
  const WeatherStateFailure({this.message});
}
