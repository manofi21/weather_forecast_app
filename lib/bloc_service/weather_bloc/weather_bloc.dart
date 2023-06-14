import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_forecast_app/model/weather_model.dart';

import '../../model/error_model.dart';
import '../../model/resut_weather_repo_model.dart';
import '../../repo/weather_repo.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepo;

  WeatherBloc({required this.weatherRepo})
      : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  Future<void> _fetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final cityName = event.city[0].toUpperCase() + event.city.substring(1, event.city.length);
      final ResultWeatherRepoModel weather = await weatherRepo.fetchWeather(cityName);
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: WeatherStatus.loaded, resultWeather: weather));
    } on ErrorModel catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
  }
}
