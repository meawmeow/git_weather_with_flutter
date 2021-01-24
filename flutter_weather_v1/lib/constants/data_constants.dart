class DataConstants {
  //VALUE
  static const String languageValue = "Language";
  static const String languageEngValue = "English";
  static const String languageThValue = "Thailand";

  static const List<String> languagesValue = ['English', 'Thailand'];

  //HTTP
  static const BaseUrl = 'https://www.metaweather.com';
  static final LocationUrl =
      (city) => '${BaseUrl}/api/location/search/?query=${city}';
  static final WeatherUrl =
      (locationId) => '${BaseUrl}/api/location/${locationId}';

  //UI
  static const String TemperatureUnitUI = "Temperature Unit";
  static const String CelsiusUI = "Celsius";
  static const String FahrenheitUI = "Fahrenheit";
  static const String AppNameUI = "Weather App";
  static const String SettingUI = "Setting";
  static const String InfoUI = "Info";
}
