import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_bloc.dart';
import 'package:flutterweatherv1/blocs/setting/setting_event.dart';
import 'package:flutterweatherv1/blocs/setting/setting_state.dart';
import 'package:flutterweatherv1/blocs/weather/weather_bloc.dart';
import 'package:flutterweatherv1/blocs/weather/weather_event.dart';
import 'package:flutterweatherv1/blocs/weather/weather_state.dart';
import 'package:flutterweatherv1/models/city.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityTextController = TextEditingController();

  Widget _buildSearchUi() {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Form(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: _cityTextController,
                  decoration: InputDecoration(
                    labelText: 'Enter a city',
                    hintText: 'Example: Bangkok',
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherEventSearch(city: _cityTextController.text));
                //Navigator.pop(context, _cityTextController.text);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityList(CityList cityList) {
    return ListView.builder(
        itemCount: cityList.cityList.length,
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              title: Text("${cityList.cityList[position].title}"),
              subtitle: Text("${cityList.cityList[position].lattLong}"),
              trailing: Text("${cityList.cityList[position].woeid}"),
              leading: Icon(
                Icons.location_city,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.pop(context, cityList.cityList[position].woeid);
              },
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a city'),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchUi(),
          Expanded(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, weatherState) {
                if (weatherState is WeatherStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (weatherState is WeatherStateSearchSuccess) {
                  return _buildCityList(weatherState.cityList);
                } else if (weatherState is WeatherStateFailure) {
                  return Text('');
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
