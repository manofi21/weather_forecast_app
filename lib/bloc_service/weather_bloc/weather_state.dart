part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  const WeatherState({
    required this.status,
    required this.resultWeather,
    required this.error,
  });

  factory WeatherState.initial() {
    return WeatherState(
      status: WeatherStatus.initial,
      resultWeather: ResultWeatherRepoModel(
        weatherModel: WeatherModel.initial(),
        listForecast: [],
      ),
      error: const ErrorModel(),
    );
  }

  final ErrorModel error;
  final WeatherStatus status;
  final ResultWeatherRepoModel resultWeather;

  @override
  List<Object> get props => [status, resultWeather, error];

  @override
  String toString() =>
      'WeatherState(status: $status, resultWeather: $resultWeather, error: $error)';

  WeatherState copyWith({
    WeatherStatus? status,
    ResultWeatherRepoModel? resultWeather,
    ErrorModel? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      resultWeather: resultWeather ?? this.resultWeather,
      error: error ?? this.error,
    );
  }
}
