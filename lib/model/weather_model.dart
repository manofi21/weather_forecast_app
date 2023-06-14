// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    required this.country,
    required this.description,
    required this.icon,
    required this.lastUpdated,
    required this.name,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.weatherName,
    this.dt,
    this.dtName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return WeatherModel(
      description: weather['description'],
      icon: weather['icon'],
      temp:
          main['temp'] is int ? (main['temp'] as int).toDouble() : main['temp'],
      tempMin: main['temp_min'] is int
          ? (main['temp_min'] as int).toDouble()
          : main['temp_min'],
      tempMax: main['temp_max'] is int
          ? (main['temp_max'] as int).toDouble()
          : main['temp_max'],
      name: '',
      country: '',
      lastUpdated: DateTime.now(),
      weatherName: weather['main'],
      dt: json['dt'],
    );
  }

  factory WeatherModel.initial() => WeatherModel(
        description: '',
        icon: '',
        temp: 100.0,
        tempMin: 100.0,
        tempMax: 100.0,
        name: '',
        country: '',
        lastUpdated: DateTime(1970),
        weatherName: '',
      );

  final String country;
  final String description;
  final String icon;
  final DateTime lastUpdated;
  final String name;
  final double temp;
  final double tempMax;
  final double tempMin;
  final String weatherName;
  final int? dt;
  final String? dtName;

  @override
  List<Object> get props {
    return [
      description,
      icon,
      temp,
      tempMin,
      tempMax,
      name,
      country,
      lastUpdated,
      weatherName,
    ];
  }

  @override
  String toString() {
    return 'WeatherModel(description: $description, icon: $icon, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, name: $name, country: $country, lastUpdated: $lastUpdated, weatherName: $weatherName)';
  }

  WeatherModel copyWith({
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    DateTime? lastUpdated,
    String? weatherName,
    int? dt,
    String? dtName,
  }) {
    return WeatherModel(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      weatherName: weatherName ?? this.weatherName,
      dt: dt ?? this.dt,
      dtName: dtName ?? this.dtName,
    );
  }
}
