import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/theme/theme_event.dart';
import 'package:flutterweatherv1/blocs/theme/theme_state.dart';
import 'package:flutterweatherv1/models/weather.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  // TODO: implement initialState
  ThemeState get initialState =>
      ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    ThemeState newThemeState;
    if (themeEvent is ThemeEventWeatherChanged) {
      final weatherCondition = themeEvent.weatherStateAbbr;
      if (weatherCondition == WeatherCondition.clear ||
          weatherCondition == WeatherCondition.lightCloud) {
        newThemeState =
            ThemeState(backgroundColor: Colors.yellow, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.hail ||
          weatherCondition == WeatherCondition.snow ||
          weatherCondition == WeatherCondition.sleet) {
        newThemeState = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.grey[900]);
      } else if (weatherCondition == WeatherCondition.heavyCloud) {
        newThemeState =
            ThemeState(backgroundColor: Colors.grey, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.heavyRain ||
          weatherCondition == WeatherCondition.lightRain ||
          weatherCondition == WeatherCondition.showers) {
        newThemeState = ThemeState(
            backgroundColor: Colors.indigo, textColor: Colors.grey[900]);
      } else if (weatherCondition == WeatherCondition.thunderstorm) {
        newThemeState = ThemeState(
            backgroundColor: Colors.deepPurple, textColor: Colors.grey[900]);
      } else {
        newThemeState = ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      }

      yield newThemeState;
    }
  }
}
