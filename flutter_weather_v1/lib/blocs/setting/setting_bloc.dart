import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_event.dart';
import 'package:flutterweatherv1/blocs/setting/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  @override
  // TODO: implement initialState
  SettingState get initialState => SettingState(
      temperatureUnit: TemperatureUnit.celsius,
      languages: SettingLanguages.English);

  //SettingsBloc():super(SettingsState(temperatureUnit: TemperatureUnit.celsius));

  @override
  Stream<SettingState> mapEventToState(SettingEvent settingEvent) async* {
    if (settingEvent is SettingEventToggleUnit) {
      //state = "settings state"
      final newSettingsState = SettingState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius,
          languages: state.languages);
      yield newSettingsState;
    }
    if (settingEvent is SettingEventDropdown) {
      final newSettingsState = SettingState(
          temperatureUnit: state.temperatureUnit,
          languages: settingEvent.language == "English"
              ? SettingLanguages.English
              : SettingLanguages.Thailand);
      yield newSettingsState;
    }
  }
}
