import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventSearch extends WeatherEvent {
  final String city;
  const WeatherEventSearch({@required this.city}) : assert(city != null);

  @override
  // TODO: implement props
  List<Object> get props => [city];
}

class WeatherEventRequested extends WeatherEvent {
  final int locationId;
  const WeatherEventRequested({@required this.locationId})
      : assert(locationId != null);

  @override
  // TODO: implement props
  List<Object> get props => [locationId];
}

class WeatherEventRefresh extends WeatherEvent {
  final int locationId;
  const WeatherEventRefresh({@required this.locationId})
      : assert(locationId != null);

  @override
  // TODO: implement props
  List<Object> get props => [locationId];
}
