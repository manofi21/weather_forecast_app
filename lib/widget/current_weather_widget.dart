import 'package:flutter/material.dart';
import 'package:weather_forecast_app/widget/show_icon.dart';
import '../model/weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherModel weather;
  const CurrentWeatherWidget({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            weather.name,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              showIcon(weather.icon),
              Text(
                '${weather.temp}℃',
                style: const TextStyle(color: Colors.black, fontSize: 60),
              ),
            ],
          ),
          Text(
            weather.weatherName,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
