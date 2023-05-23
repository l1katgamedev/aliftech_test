import 'dart:developer';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}


void abc (DateTime other) {
  log("${other.year}");
}