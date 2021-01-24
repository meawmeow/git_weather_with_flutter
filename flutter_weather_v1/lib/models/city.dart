import 'package:equatable/equatable.dart';

class CityList {
  List<City> cityList;

  CityList({this.cityList});

  CityList.fromJson(List<dynamic> parsedJson) {
    if (parsedJson != null) {
      cityList = List<City>();
      cityList = parsedJson.map((i) => City.fromJson(i)).toList();
    }
  }
}

class City extends Equatable {
  String title;
  String locationType;
  int woeid;
  String lattLong;

  City({this.title, this.locationType, this.woeid, this.lattLong});

  City.fromJson(Map<String, dynamic> json) {
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

  @override
  // TODO: implement props
  List<Object> get props => [title, locationType, woeid, lattLong];
}
