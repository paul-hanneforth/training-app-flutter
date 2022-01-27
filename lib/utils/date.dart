class NewDate extends DateTime {

  NewDate() : super.now();

  NewDate.fromDateTime(DateTime dateTime) : super.fromMicrosecondsSinceEpoch(dateTime.microsecondsSinceEpoch);

  String format() {
    return day.toString() + "." + month.toString() + "." + year.toString();
  }
  String detailedFormat() {
    return hour.toString() + ":" + minute.toString() + "@" + day.toString() + "." + month.toString() + "." + year.toString();
  }

  NewDate toDayStart() {
    final DateTime dayStart = subtract(Duration(microseconds: microsecond))
      .subtract(Duration(milliseconds: millisecond))
      .subtract(Duration(seconds: second))
      .subtract(Duration(minutes: minute))
      .subtract(Duration(hours: hour));

    return NewDate.fromDateTime(dayStart);
  }

}