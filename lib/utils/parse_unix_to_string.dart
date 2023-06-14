import 'package:intl/intl.dart';
const String patternDateStandart = "EEE, MMM dd";

String parseUnixToString(int millisecond) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(millisecond * 1000).toLocal();
  final parseToString = DateFormat(patternDateStandart).format(dateTime);
  return parseToString.split(',').join(',\n');
}