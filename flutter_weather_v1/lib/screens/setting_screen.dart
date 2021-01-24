import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_event.dart';
import 'package:flutterweatherv1/blocs/setting/setting_state.dart';
import 'package:flutterweatherv1/constants/data_constants.dart';
import 'package:flutterweatherv1/screens/widgets/animated_wave.dart';
import 'package:flutterweatherv1/utils/shared_data.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DataConstants.SettingUI),
      ),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, settingState) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    color: Colors.teal,
                    child: ListTile(
                      title: Text(
                        DataConstants.TemperatureUnitUI,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      isThreeLine: true,
                      subtitle: Text(
                        settingState.temperatureUnit == TemperatureUnit.celsius
                            ? DataConstants.CelsiusUI
                            : DataConstants.FahrenheitUI,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Switch(
                        activeTrackColor: Colors.orangeAccent,
                        activeColor: Colors.yellow,
                        value: settingState.temperatureUnit ==
                            TemperatureUnit.celsius,
                        onChanged: (_) => BlocProvider.of<SettingBloc>(context)
                            .add(SettingEventToggleUnit()),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.teal[900],
                    height: 1,
                  ),
                  Container(
                    height: 60,
                    color: Colors.teal,
                    child: ListTile(
                      title: Text(
                        DataConstants.languageValue,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        settingState.languages == SettingLanguages.English
                            ? DataConstants.languagesValue[0]
                            : DataConstants.languagesValue[1],
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: new Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.teal.shade600,
                        ),
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.orangeAccent,
                          value:
                              settingState.languages == SettingLanguages.English
                                  ? DataConstants.languagesValue[0]
                                  : DataConstants.languagesValue[1],
                          icon: Icon(
                            Icons.arrow_downward,
                            color: Colors.orangeAccent,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          underline: Container(
                            height: 2,
                            color: Colors.orangeAccent,
                          ),
                          onChanged: (String value) {
                            BlocProvider.of<SettingBloc>(context)
                                .add(SettingEventDropdown(language: value));
                            DataSharedPreferences.SaveDataStr(
                                DataSharedPreferences.LANGUAGE, value);
                          },
                          items: DataConstants.languagesValue
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  buildIcon(value),
                                  SizedBox(width: 10),
                                  Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildIcon(String str) {
    switch (str) {
      case DataConstants.languageEngValue:
        {
          return Icon(
            Icons.map,
            color: Colors.white,
          );
        }
      case DataConstants.languageThValue:
        {
          return Icon(
            Icons.map,
            color: Colors.white,
          );
        }
    }
  }
}
