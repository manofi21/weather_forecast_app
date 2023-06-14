bool isSameDayUnix(int timestamp1, int timestamp2) {
  DateTime date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
  DateTime date2 = DateTime.fromMillisecondsSinceEpoch(timestamp2 * 1000);
  
  print('${date1.day} == ${date2.day}');
  return date1.day == date2.day;
}