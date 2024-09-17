import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toHumanReadable() {
    final now = DateTime.now();
    final diffInDays = difference(now).inDays;
    String day;
    if (diffInDays == 0) {
      day = 'Today';
    } else if (diffInDays == 1) {
      day = 'Tomorrow';
    } else {
      day = DateFormat('MMM dd').format(this);
    }
    final timeString = DateFormat('HH:mm').format(this);
    return '$day at $timeString';
  }

  DateTime toTheClosestHourAfter(Duration duration) {
    final time = add(duration);
    final minutes = time.minute;
    final minutesToClosestHour = minutes >= 30 ? 60 - minutes : -minutes;
    return time.add(Duration(minutes: minutesToClosestHour));
  }
}
