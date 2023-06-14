import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_forecast_app/model/geocoding_request_model.dart';
import 'package:weather_forecast_app/model/weather_model.dart';

import '../model/weather_exception.dart';
import 'error_response.dart';

const String weatherBaseUrl = 'http://api.openweathermap.org';
const String apiKey = '1c63fdcd1ddef44d0def8bdcb7705539';
const String kLimit = '1';
const String kUnit = 'metric';

class WeatherService {
  Dio _myDio() {
    final weatherOption = BaseOptions(
      baseUrl: weatherBaseUrl,
    );

    return Dio(weatherOption);
  }

  Future<List<WeatherModel>> getForecast(
      GeocodingRequestModel directGeocoding) async {
    try {
      final response = await _myDio().get(
        '/data/2.5/forecast/',
        queryParameters: {
          'lat': '${directGeocoding.lat}',
          'lon': '${directGeocoding.lon}',
          'appid': dotenv.env['APPID'],
          'units': kUnit,
        },
      );

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final responseDataList = response.data["list"];

      if (responseDataList is List) {
        final dataList =
            responseDataList.map((e) => WeatherModel.fromJson(e)).toList();

        return dataList;
      }

      return [];
    } catch (e) {
      throw WeatherException(e.toString());
    }
  }

  Future<WeatherModel> getWeather(GeocodingRequestModel directGeocoding) async {
    try {
      final response = await _myDio().get(
        '/data/2.5/weather',
        queryParameters: {
          'lat': '${directGeocoding.lat}',
          'lon': '${directGeocoding.lon}',
          'units': kUnit,
          'appid': dotenv.env['APPID'],
        },
      );

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      final WeatherModel weather = WeatherModel.fromJson(response.data);
      return weather;
    } catch (e) {
      throw WeatherException(e.toString());
    }
  }

  Future<GeocodingRequestModel> getGeocodingByCity(String city) async {
    try {
      final response = await _myDio().get('/geo/1.0/direct', queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      });

      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }

      if ((response.data as List).isEmpty) {
        throw 'Cannot get the location of $city';
      }

      final directGeocoding = GeocodingRequestModel.fromJson(response.data);

      return directGeocoding;
    } catch (e) {
      throw WeatherException(e.toString());
    }
  }
}