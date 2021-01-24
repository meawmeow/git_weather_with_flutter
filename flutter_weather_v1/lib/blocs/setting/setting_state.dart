import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum TemperatureUnit { fahrenheit, celsius }
enum SettingLanguages { English, Thailand }

class SettingState extends Equatable {
  final TemperatureUnit temperatureUnit;
  final SettingLanguages languages;
  const SettingState({@required this.temperatureUnit, @required this.languages})
      : assert(temperatureUnit != null),
        assert(languages != null);

  @override
  // TODO: implement props
  List<Object> get props => [temperatureUnit, languages];
}
