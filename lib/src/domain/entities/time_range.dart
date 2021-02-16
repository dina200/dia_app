class TimeRange {
  final DateTime from;
  final DateTime to;

  TimeRange._(this.from, this.to) : assert(from != null && to != null);

  factory TimeRange.getEntityByFilter(TimeRangeFilters filter) {
    switch (filter) {
      case TimeRangeFilters.today: return TimeRange._getRangeForToday();
      case TimeRangeFilters.week: return TimeRange._getRangeForWeek();
      case TimeRangeFilters.thisMonth: return TimeRange._getRangeForMonth();
      case TimeRangeFilters.thisYear: return TimeRange._getRangeForThisYear();
      case TimeRangeFilters.wholeTime: return TimeRange._getWholeRange();
    }
    return throw AssertionError('$filter : the filter doesn\'t exist');
  }

  factory TimeRange._getRangeForDay(DateTime dateTime) {
    final day = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return TimeRange._(
      day,
      day.add(Duration(days: 1)),
    );
  }

  factory TimeRange._getRangeForToday() {
    return TimeRange._getRangeForDay(_now);
  }

  factory TimeRange._getRangeForWeek() {
    final today = DateTime(_now.year, _now.month, _now.day + 1);
    return TimeRange._(
      today.subtract(Duration(days: Duration.hoursPerDay * 7)),
      today,
    );
  }

  factory TimeRange._getRangeForMonth() {
    return TimeRange._(
      DateTime(_now.year, _now.month).subtract(Duration(days: 30)),
      _now,
    );
  }

  factory TimeRange._getRangeForThisYear() {
    return TimeRange._(
      DateTime(_now.year),
      DateTime(_now.year + 1),
    );
  }

  factory TimeRange._getWholeRange() {
    return TimeRange._(
      DateTime.fromMillisecondsSinceEpoch(0),
      DateTime.fromMillisecondsSinceEpoch(Duration.hoursPerDay * 7 * 100000000000),
    );
  }

  static DateTime get _now => DateTime.now();
}

enum TimeRangeFilters {
  today,
  week,
  thisMonth,
  thisYear,
  wholeTime,
}

