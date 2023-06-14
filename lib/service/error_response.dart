import 'package:dio/dio.dart';

String httpErrorHandler(Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.statusMessage;

  final String errorMessage =
      'Request failed\nStatus Code: $statusCode\nReason: $reasonPhrase';

  return errorMessage;
}
