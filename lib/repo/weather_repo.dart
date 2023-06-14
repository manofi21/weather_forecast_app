import 'package:weather_forecast_app/model/error_model.dart';
import 'package:weather_forecast_app/model/weather_model.dart';

import '../model/resut_weather_repo_model.dart';
import '../model/weather_exception.dart';
import '../service/weather_service.dart';

class WeatherRepo {
  final WeatherService weatherService;
  WeatherRepo(this.weatherService);

  Future<ResultWeatherRepoModel> fetchWeather(String city) async {
    try {
      final dataCityResult = await weatherService.getGeocodingByCity(city);

      final getDataValue = await Future.wait(
        [
          weatherService.getWeather(dataCityResult),
          weatherService.getForecast(dataCityResult)
        ],
      );

      return ResultWeatherRepoModel(
        weatherModel: (getDataValue[0] as WeatherModel).copyWith(name: city),
        listForecast: getDataValue[1] as List<WeatherModel>,
      );
    } on WeatherException catch (e) {
      throw ErrorModel(errMsg: e.message);
    } catch (e) {
      throw ErrorModel(errMsg: e.toString());
    }
  }
}
