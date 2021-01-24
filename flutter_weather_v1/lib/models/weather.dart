import 'package:equatable/equatable.dart';

/*{
"consolidated_weather": [
{
"id": 6362335843188736,
"weather_state_name": "Showers",
"weather_state_abbr": "s",
"wind_direction_compass": "WSW",
"created": "2020-09-06T12:20:03.693997Z",
"applicable_date": "2020-09-06",
"min_temp": 11.835,
"max_temp": 19.905,
"the_temp": 18.255,
"wind_speed": 4.07796079531801,
"wind_direction": 257.50242916649194,
"air_pressure": 1020.0,
"humidity": 59,
"visibility": 11.565892686709615,
"predictability": 73
}*/

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;
  final int humidity;
  final double wind_speed;
  final Parent parent;

  const Weather(
      {this.weatherCondition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.lastUpdated,
      this.location,
      this.humidity,
      this.wind_speed,
      this.parent});

  @override
  // TODO: implement props
  List<Object> get props => [
        weatherCondition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location,
        humidity,
        wind_speed,
        parent,
      ];

  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    print('${jsonObject['parent']}');
    return Weather(
        weatherCondition: _mapStringToWeatherCondition(
                consolidatedWeather['weather_state_abbr']) ??
            '',
        formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
        minTemp: consolidatedWeather['min_temp'] as double,
        temp: consolidatedWeather['the_temp'] as double,
        maxTemp: consolidatedWeather['max_temp'] as double,
        locationId:
            jsonObject['woeid'] as int, //Where On Earth Identifier = woeid
        created: consolidatedWeather['created'],
        lastUpdated: DateTime.now(),
        location: jsonObject['title'],
        humidity: consolidatedWeather['humidity'],
        wind_speed: consolidatedWeather['wind_speed'],
        parent: Parent.fromJson(jsonObject['parent']));
  }

  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }
}

class Parent {
  String title;
  String locationType;
  int woeid;
  String lattLong;

  Parent({this.title, this.locationType, this.woeid, this.lattLong});

  Parent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    locationType = json['location_type'];
    woeid = json['woeid'];
    lattLong = json['latt_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['location_type'] = this.locationType;
    data['woeid'] = this.woeid;
    data['latt_long'] = this.lattLong;
    return data;
  }
}
