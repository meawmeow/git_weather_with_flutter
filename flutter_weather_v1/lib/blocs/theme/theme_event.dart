import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterweatherv1/models/weather.dart';
import 'package:flutterweatherv1/models/weatherList.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final WeatherStateAbbr weatherStateAbbr;

  const ThemeEventWeatherChanged({@required this.weatherStateAbbr})
      : assert(weatherStateAbbr != null);

  @override
  // TODO: implement props
  List<Object> get props => [weatherStateAbbr];
}
