import 'package:flutter/material.dart';
import 'package:weather_forecast_app/widget/show_icon.dart';

import '../model/weather_model.dart';
import '../utils/parse_unix_to_string.dart';

class ForecastListWidget extends StatelessWidget {
  const ForecastListWidget({
    super.key,
    required this.listForecased,
  });

  final List<WeatherModel> listForecased;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final value = listForecased[index];
        return Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: index == 0 ? 10 : 5,
            right: index == listForecased.length - 1 ? 10 : 5,
          ),
          color: index % 2 == 0 ? Colors.blue[900] : Colors.blue,
          child: Column(
            children: [
              Text(
                parseUnixToString(value.dt ?? 0),
                textAlign: TextAlign.center,
              ),
              showIcon(value.icon, height: 40, width: 40),
              Text(
                'Max temp:\n${value.tempMax.toString()} ℃',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                'Min temp:\n${value.tempMin.toString()} ℃',
                textAlign: TextAlign.center,
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
      itemCount: listForecased.length,
    );
  }
}
