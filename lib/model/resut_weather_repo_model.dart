import 'package:weather_forecast_app/model/weather_model.dart';

class ResultWeatherRepoModel {
  final WeatherModel weatherModel;
  final List<WeatherModel> listForecast;

  ResultWeatherRepoModel({
    required this.weatherModel,
    required this.listForecast,
  });
}
