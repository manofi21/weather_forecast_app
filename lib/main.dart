import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_forecast_app/widget/current_weather_widget.dart';
import 'package:weather_forecast_app/widget/forecast_list_widget.dart';

import 'bloc_service/weather_bloc/weather_bloc.dart';
import 'repo/weather_repo.dart';
import 'service/weather_service.dart';
import 'show_dialog/show_error_dialog.dart';
import 'widget/search_city_text_field.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepo(WeatherService()),
      child: BlocProvider(
        create: (context) => WeatherBloc(
          weatherRepo: context.read<WeatherRepo>(),
        ),
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Weather Forecast'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<WeatherBloc>().add(const FetchWeatherEvent(city: "Depok"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SearchCityTextField(
            onPressed: (isValidated, value) {
              if (isValidated) {
                context.read<WeatherBloc>().add(FetchWeatherEvent(city: value));
              }
            },
          ),
        ),
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state.status == WeatherStatus.error) {
            showErrorDialog(context, state.error.errMsg);
          }
        },
        builder: (context, state) {
          if (state.status == WeatherStatus.loading) {
            return const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.status == WeatherStatus.loaded) {
            final listForecased = state.resultWeather.listForecast;
            final currentWeather = state.resultWeather.weatherModel;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CurrentWeatherWidget(
                  weather: currentWeather,
                ),
                const SizedBox(height: 30),
                Container(
                  color: Colors.blue,
                  height: 180,
                  child: ForecastListWidget(listForecased: listForecased),
                )
              ],
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "Please search the country first",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
