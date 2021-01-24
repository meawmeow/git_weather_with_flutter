import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterweatherv1/constants/data_constants.dart';
import 'package:flutterweatherv1/models/city.dart';
import 'package:flutterweatherv1/models/weather.dart';
import 'package:flutterweatherv1/models/weatherList.dart';
import 'package:http/http.dart' as http;

//const baseUrl = 'https://www.metaweather.com';
//final locationUrl = (city) => '${baseUrl}/api/location/search/?query=${city}';
//final weatherUrl = (locationId) => '${baseUrl}/api/location/${locationId}';

class WeatherRepository {
  final http.Client httpClient;
  //constructor
  WeatherRepository({@required this.httpClient}) : assert(httpClient != null);

  Future<CityList> getLocationIdFromCityList(String city) async {
    final response = await this.httpClient.get(DataConstants.LocationUrl(city));
    if (response.statusCode == 200) {
      var cities = jsonDecode(response.body) as List;
      final citylist = CityList.fromJson(cities);
      return citylist;
    } else {
      throw Exception('Error getting location id of : ${city}');
    }
  }

  Future<WeatherList> fetchWeather(int locationId) async {
    final response =
        await this.httpClient.get(DataConstants.WeatherUrl(locationId));
    if (response.statusCode != 200) {
      throw Exception('Error getting weather from locationId: ${locationId}');
    }
    final weatherJson = jsonDecode(response.body);
    return WeatherList.fromJson(weatherJson);
  }

  Future<WeatherList> getWeatherFromCityLocationId(int locationId) async {
    print('getWeatherFromCityLocationId ${locationId}');
    return fetchWeather(locationId);
  }
}
