import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_event.dart';
import 'package:flutterweatherv1/blocs/setting/setting_state.dart';
import 'package:flutterweatherv1/blocs/theme/theme_bloc.dart';
import 'package:flutterweatherv1/blocs/theme/theme_event.dart';
import 'package:flutterweatherv1/blocs/theme/theme_state.dart';
import 'package:flutterweatherv1/blocs/weather/weather_bloc.dart';
import 'package:flutterweatherv1/blocs/weather/weather_event.dart';
import 'package:flutterweatherv1/blocs/weather/weather_state.dart';
import 'package:flutterweatherv1/constants/data_constants.dart';
import 'package:flutterweatherv1/screens/city_search_screen.dart';
import 'package:flutterweatherv1/screens/info_screen.dart';
import 'package:flutterweatherv1/screens/setting_screen.dart';
import 'package:flutterweatherv1/screens/widgets/animated_background.dart';
import 'package:flutterweatherv1/screens/widgets/box_message_animated.dart';
import 'package:flutterweatherv1/screens/widgets/animated_wave.dart';
import 'package:flutterweatherv1/screens/widgets/temperture_widget.dart';
import 'package:flutterweatherv1/utils/shared_data.dart';
import 'package:flutterweatherv1/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Completer<void> _completer;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();

    DataSharedPreferences.getReaderInt(DataSharedPreferences.CITY_ID)
        .then((int id) {
      BlocProvider.of<WeatherBloc>(context)
          .add(WeatherEventRequested(locationId: id));
    });

    DataSharedPreferences.getReaderStr(DataSharedPreferences.LANGUAGE)
        .then((String value) {
      if (value == "") {
        BlocProvider.of<SettingBloc>(context).add(
            SettingEventDropdown(language: DataConstants.languageEngValue));
      } else {
        BlocProvider.of<SettingBloc>(context)
            .add(SettingEventDropdown(language: value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('Size height = ${MediaQuery.of(context).size.height}');
    return Scaffold(
      appBar: AppBar(
        title: Text(DataConstants.AppNameUI),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InfoScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              var locationId = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CitySearchScreen()));
              if (locationId != null) {
                BlocProvider.of<WeatherBloc>(context).add(WeatherEventRequested(
                    locationId: int.parse(locationId.toString())));
                DataSharedPreferences.SaveDataInt(DataSharedPreferences.CITY_ID,
                    int.parse(locationId.toString()));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventWeatherChanged(
                  weatherStateAbbr: weatherState
                      .weatherList.consolidatedWeather[0].weatherStateAbbr));

              _completer?.complete();
              _completer = Completer();
            }
          },
          // ignore: missing_return
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (weatherState is WeatherStateSuccess) {
              final weatherList = weatherState.weatherList;
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                    // ignore: missing_return
                    onRefresh: () {
                      BlocProvider.of<WeatherBloc>(context).add(
                          WeatherEventRefresh(locationId: weatherList.woeid));

                      return _completer.future;
                    },
                    child: Container(
                      color: Colors.blue[400],
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: new ExactAssetImage(
                                    (new Random().nextInt(7) <= 3
                                        ? 'assets/images/bg1.png'
                                        : 'assets/images/bg2.png')),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Container(),
                              ),
                              Expanded(
                                child: Container(
                                  child: AnimatedWave(
                                      height: 150, speed: 1, offset: 10),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Container(),
                              ),
                              Expanded(
                                child: Container(
                                  child: AnimatedWave(
                                      height: 100, speed: 2, offset: 5),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Flexible(flex: 3, child: Container()),
                              Expanded(
                                child: Container(
                                  child: AnimatedWave(
                                      height: 50, speed: 3, offset: 2),
                                ),
                              ),
                            ],
                          ),
                          ListView(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      //AnimatedBackground(),
                                      Container(
                                        decoration: Styles.bocDecorationType4,
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  weatherList.parent.title,
                                                  style: GoogleFonts.play(
                                                    textStyle: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: themeState
                                                            .textColor),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  weatherList.title,
                                                  style: GoogleFonts.play(
                                                    textStyle: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2),
                                            ),
                                            Center(
                                              child: Text(
                                                'Updated: ${TimeOfDay.fromDateTime(weatherList.datelastUpdated).format(context)}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: themeState.textColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  TemperatureWidget(
                                      weatherList: weatherState.weatherList),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (weatherState is WeatherStateFailure) {
              return Text(
                'Something went wrong',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              );
            }
//            if (weatherState is WeatherStateInitial) {
//              return Text('weatherState ${weatherState}');
//            }
            return Center(
              child: Text(
                'select a location first !',
                style: TextStyle(fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
