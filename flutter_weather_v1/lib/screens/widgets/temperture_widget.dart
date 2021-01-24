import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_state.dart';
import 'package:flutterweatherv1/blocs/theme/theme_bloc.dart';
import 'package:flutterweatherv1/blocs/theme/theme_state.dart';
import 'package:flutterweatherv1/constants/app_language_strings.dart';
import 'package:flutterweatherv1/models/weather.dart';
import 'package:flutterweatherv1/models/weatherList.dart';
import 'package:flutterweatherv1/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_icons/weather_icons.dart';

import 'animated_background.dart';
import 'animated_wave.dart';

class TemperatureWidget extends StatelessWidget {
  final WeatherList weatherList;
  final double iconSize = 80;

  TemperatureWidget({Key key, @required this.weatherList})
      : assert(weatherList != null),
        super(key: key);

  //Convert celcius to fahrenheit
  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();
  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';

  BoxedIcon _mapWeatherConditionToIcon({WeatherStateAbbr weatherStateAbbr}) {
    switch (weatherStateAbbr) {
      case WeatherStateAbbr.clear:
      case WeatherStateAbbr.lightCloud:
        return BoxedIcon(
          WeatherIcons.day_sunny,
          size: iconSize,
          color: Colors.yellow,
        );
        break;
      case WeatherStateAbbr.hail:
      case WeatherStateAbbr.snow:
      case WeatherStateAbbr.sleet:
        return BoxedIcon(
          WeatherIcons.snow,
          size: iconSize,
          color: Colors.white70,
        );
        break;
      case WeatherStateAbbr.heavyCloud:
        return BoxedIcon(
          WeatherIcons.cloud_up,
          size: iconSize,
          color: Colors.white70,
        );
        break;
      case WeatherStateAbbr.heavyRain:
      case WeatherStateAbbr.lightRain:
      case WeatherStateAbbr.showers:
        return BoxedIcon(
          WeatherIcons.rain,
          size: iconSize,
          color: Colors.grey[800],
        );
        break;
      case WeatherStateAbbr.thunderstorm:
        return BoxedIcon(
          WeatherIcons.thunderstorm,
          size: iconSize,
          color: Colors.white70,
        );
        break;
      case WeatherStateAbbr.unknown:
        return BoxedIcon(
          WeatherIcons.sunset,
          size: iconSize,
          color: Colors.yellowAccent,
        );
        break;
    }
    return BoxedIcon(
      WeatherIcons.sunset,
      size: iconSize,
      color: Colors.yellowAccent,
    );
  }

  Image _mapWeatherConditionToImage({WeatherStateAbbr weatherStateAbbr}) {
    switch (weatherStateAbbr) {
      case WeatherStateAbbr.clear:
      case WeatherStateAbbr.lightCloud:
        return Image.asset(
          'assets/images/weath_icon4.png',
          width: 110,
          height: 110,
        );
        break;
      case WeatherStateAbbr.hail:
      case WeatherStateAbbr.snow:
      case WeatherStateAbbr.sleet:
        return Image.asset(
          'assets/images/weath_icon7.png',
          width: 110,
          height: 110,
        );
        break;
      case WeatherStateAbbr.heavyCloud:
        return Image.asset(
          'assets/images/weath_icon5.png',
          width: 110,
          height: 110,
        );
        break;
      case WeatherStateAbbr.heavyRain:
      case WeatherStateAbbr.lightRain:
      case WeatherStateAbbr.showers:
        return Image.asset(
          'assets/images/weath_icon3.png',
          width: 110,
          height: 110,
        );
        break;
      case WeatherStateAbbr.thunderstorm:
        return Image.asset(
          'assets/images/weath_icon8.png',
          width: 110,
          height: 110,
        );
        break;
      case WeatherStateAbbr.unknown:
        return Image.asset(
          'assets/images/weath_icon4.png',
          width: 110,
          height: 110,
        );
        break;
    }
    return Image.asset(
      'assets/images/weath_icon4.png',
      width: 110,
      height: 110,
    );
  }

  Widget buildTxtList(
    SettingState _settingState,
    ThemeState _themeState,
    int position,
  ) {
    TextStyle TEXT_STYLE = TextStyle(
        fontSize: 16,
        letterSpacing: 1,
        fontWeight: FontWeight.w300,
        color: _themeState.textColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '${StringLangages.getStrApp(_settingState.languages == SettingLanguages.English ? Langages.Eng : Langages.Th).Date}: ${weatherList.consolidatedWeather[position].applicableDate}',
          style: GoogleFonts.play(
            textStyle: TextStyle(
                fontSize: 17,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: _themeState.textColor),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${StringLangages.getStrApp(_settingState.languages == SettingLanguages.English ? Langages.Eng : Langages.Th).Mintemp}: ${_formattedTemperature(weatherList.consolidatedWeather[position].minTemp, _settingState.temperatureUnit)}',
          style: GoogleFonts.play(
            textStyle: TEXT_STYLE,
          ),
        ),
        Text(
          '${StringLangages.getStrApp(_settingState.languages == SettingLanguages.English ? Langages.Eng : Langages.Th).Temp}: ${_formattedTemperature(weatherList.consolidatedWeather[position].theTemp, _settingState.temperatureUnit)}',
          style: GoogleFonts.play(
            textStyle: TEXT_STYLE,
          ),
        ),
        Text(
          '${StringLangages.getStrApp(_settingState.languages == SettingLanguages.English ? Langages.Eng : Langages.Th).Maxtemp}: ${_formattedTemperature(weatherList.consolidatedWeather[position].maxTemp, _settingState.temperatureUnit)}',
          style: GoogleFonts.play(
            textStyle: TEXT_STYLE,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${StringLangages.getStrApp(_settingState.languages == SettingLanguages.English ? Langages.Eng : Langages.Th).Humidity}: ${weatherList.consolidatedWeather[position].humidity}',
          style: GoogleFonts.play(
            textStyle: TEXT_STYLE,
          ),
        ),
      ],
    );
  }

  Widget buildView(
      WeatherList weatherList, ThemeState _themeState, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: weatherList.consolidatedWeather.length,
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
//              mainAxisAlignment: (position % 2 == 0)
//                  ? MainAxisAlignment.end
//                  : MainAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //Add an icon here
                Column(
                  children: <Widget>[
                    _mapWeatherConditionToIcon(
                        weatherStateAbbr: weatherList
                            .consolidatedWeather[position].weatherStateAbbr),
//                    Image.asset(
//                      'assets/images/furry${(position + 1) >= 4 ? (1 + new Random().nextInt(4 - 1)) : (position + 1)}.png',
//                      color: Color.fromRGBO(255, 255, 255, 1),
//                      colorBlendMode: BlendMode.modulate,
//                      width: 120,
//                    ),
                  ],
                ),

                //AnimatedBackground(),

                Container(
                  height: 150,
                  width: 220,
                  decoration: Styles.bocDecorationType2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                    child: BlocBuilder<SettingBloc, SettingState>(
                      builder: (context, settingsState) {
                        return Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Container(),
                                ),
                                Expanded(
                                  child: Container(
                                    child: AnimatedWave(
                                      height: 150,
                                      speed: 2,
                                      offset: (new Random().nextDouble() * 4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 30,
                              top: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  buildTxtList(
                                      settingsState, _themeState, position),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;

    return SingleChildScrollView(
      child: Container(
        child: buildView(weatherList, _themeState, context),
      ),
    );
  }
}
