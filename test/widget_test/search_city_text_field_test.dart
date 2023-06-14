import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast_app/widget/search_city_text_field.dart';

void main() {
  testWidgets(
    'Search Field Should return validation because field is Empty',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchCityTextField(
              onPressed: (isValidated, value) {},
            ),
          ),
        ),
      );

      final findSearchButton = find.byIcon(Icons.search);

      await tester.tap(findSearchButton);
      
      await tester.pump();

      final findTextValidation = find.textContaining('Field cannot be Empty');
      
      expect(findTextValidation, findsOneWidget);
    },
  );
}
