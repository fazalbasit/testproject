import 'package:flutter/material.dart';

class DatesProvider extends ChangeNotifier {
  List<DateTime> _dates;

  DatesProvider(this._dates);

  List<DateTime> get dates => _dates;

  void updateDates(List<DateTime> newDates) {
    _dates = newDates;
    notifyListeners();
  }
}

List<DateTime> _getRemainingDatesInMonth() {
  List<DateTime> dates = [];
  DateTime now = DateTime.now();
  DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
  DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

  for (DateTime date = tomorrow;
      date.isBefore(lastDayOfMonth);
      date = date.add(Duration(days: 1))) {
    dates.add(date);
  }
  return dates;
}
