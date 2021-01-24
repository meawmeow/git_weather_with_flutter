import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/weather/weather_event.dart';
import 'package:flutterweatherv1/blocs/weather/weather_state.dart';
import 'package:flutterweatherv1/models/city.dart';
import 'package:flutterweatherv1/models/weather.dart';
import 'package:flutterweatherv1/models/weatherList.dart';
import 'package:flutterweatherv1/repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherStateInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventRequested) {
      yield WeatherStateLoading();
      try {
        final WeatherList weather = await weatherRepository
            .getWeatherFromCityLocationId(weatherEvent.locationId);
        yield WeatherStateSuccess(weatherList: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        final WeatherList weather = await weatherRepository
            .getWeatherFromCityLocationId(weatherEvent.locationId);
        yield WeatherStateSuccess(weatherList: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventSearch) {
      yield WeatherStateLoading();
      try {
        final CityList cityList = await weatherRepository
            .getLocationIdFromCityList(weatherEvent.city);
        yield WeatherStateSearchSuccess(cityList: cityList);
      } catch (exception) {
        yield WeatherStateFailure(message: exception.toString());
      }
    }
  }
}
