import 'package:equatable/equatable.dart';

class WeatherList {
  List<ConsolidatedWeather> consolidatedWeather;
  String time;
  String sunRise;
  String sunSet;
  String timezoneName;
  Parent parent;
  List<Sources> sources;
  String title;
  String locationType;
  int woeid;
  String lattLong;
  String timezone;
  DateTime datelastUpdated;

  WeatherList(
      {this.consolidatedWeather,
      this.time,
      this.sunRise,
      this.sunSet,
      this.timezoneName,
      this.parent,
      this.sources,
      this.title,
      this.locationType,
      this.woeid,
      this.lattLong,
      this.timezone,
      this.datelastUpdated});

  WeatherList.fromJson(Map<String, dynamic> json) {
    if (json['consolidated_weather'] != null) {
      consolidatedWeather = new List<ConsolidatedWeather>();
      json['consolidated_weather'].forEach((v) {
        consolidatedWeather.add(new ConsolidatedWeather.fromJson(v));
      });
    }
    time = json['time'];
    sunRise = json['sun_rise'];
    sunSet = json['sun_set'];
    timezoneName = json['timezone_name'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    if (json['sources'] != null) {
      sources = new List<Sources>();
      json['sources'].forEach((v) {
        sources.add(new Sources.fromJson(v));
      });
    }
    title = json['title'];
    locationType = json['location_type'];
    woeid = json['woeid'];
    lattLong = json['latt_long'];
    timezone = json['timezone'];
    datelastUpdated = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.consolidatedWeather != null) {
      data['consolidated_weather'] =
          this.consolidatedWeather.map((v) => v.toJson()).toList();
    }
    data['time'] = this.time;
    data['sun_rise'] = this.sunRise;
    data['sun_set'] = this.sunSet;
    data['timezone_name'] = this.timezoneName;
    if (this.parent != null) {
      data['parent'] = this.parent.toJson();
    }
    if (this.sources != null) {
      data['sources'] = this.sources.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['location_type'] = this.locationType;
    data['woeid'] = this.woeid;
    data['latt_long'] = this.lattLong;
    data['timezone'] = this.timezone;
    return data;
  }
}

enum WeatherStateAbbr {
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

class ConsolidatedWeather extends Equatable {
  int id;
  String weatherStateName;
  WeatherStateAbbr weatherStateAbbr;
  String windDirectionCompass;
  String created;
  String applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  int humidity;
  double visibility;
  int predictability;

  ConsolidatedWeather(
      {this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability});

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        weatherStateName,
        weatherStateAbbr,
        windDirectionCompass,
        created,
        applicableDate,
        minTemp,
        maxTemp,
        theTemp,
        windSpeed,
        windDirection,
        airPressure,
        humidity,
        visibility,
        predictability
      ];

  ConsolidatedWeather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weatherStateName = json['weather_state_name'];
    weatherStateAbbr =
        _mapStringToWeatherCondition(json['weather_state_abbr']) ?? '';
    windDirectionCompass = json['wind_direction_compass'];
    created = json['created'];
    applicableDate = json['applicable_date'];
    minTemp = json['min_temp'];
    maxTemp = json['max_temp'];
    theTemp = json['the_temp'];
    windSpeed = json['wind_speed'];
    windDirection = json['wind_direction'];
    airPressure = json['air_pressure'];
    humidity = json['humidity'];
    visibility = json['visibility'];
    predictability = json['predictability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weather_state_name'] = this.weatherStateName;
    data['weather_state_abbr'] = this.weatherStateAbbr;
    data['wind_direction_compass'] = this.windDirectionCompass;
    data['created'] = this.created;
    data['applicable_date'] = this.applicableDate;
    data['min_temp'] = this.minTemp;
    data['max_temp'] = this.maxTemp;
    data['the_temp'] = this.theTemp;
    data['wind_speed'] = this.windSpeed;
    data['wind_direction'] = this.windDirection;
    data['air_pressure'] = this.airPressure;
    data['humidity'] = this.humidity;
    data['visibility'] = this.visibility;
    data['predictability'] = this.predictability;
    return data;
  }

  static WeatherStateAbbr _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherStateAbbr> map = {
      'sn': WeatherStateAbbr.snow,
      'sl': WeatherStateAbbr.sleet,
      'h': WeatherStateAbbr.hail,
      't': WeatherStateAbbr.thunderstorm,
      'hr': WeatherStateAbbr.heavyRain,
      'lr': WeatherStateAbbr.lightRain,
      's': WeatherStateAbbr.showers,
      'hc': WeatherStateAbbr.heavyCloud,
      'lc': WeatherStateAbbr.lightCloud,
      'c': WeatherStateAbbr.clear
    };
    return map[inputString] ?? WeatherStateAbbr.unknown;
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

class Sources {
  String title;
  String slug;
  String url;
  int crawlRate;

  Sources({this.title, this.slug, this.url, this.crawlRate});

  Sources.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    url = json['url'];
    crawlRate = json['crawl_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['url'] = this.url;
    data['crawl_rate'] = this.crawlRate;
    return data;
  }
}
