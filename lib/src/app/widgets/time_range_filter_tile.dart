import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'package:dia_app/src/domain/entities/time_range.dart';

typedef SortByTimeRangeCallback = void Function(TimeRangeFilters filter);

class TimeRangeFilterTile extends StatefulWidget {
  final TimeRangeFilters initialValue;
  final SortByTimeRangeCallback onSort;

  const TimeRangeFilterTile({
    Key key,
    TimeRangeFilters initialValue,
    @required this.onSort,
  })  : this.initialValue = initialValue ?? TimeRangeFilters.today,
        assert(onSort != null),
        super(key: key);

  @override
  _TimeRangeFilterTileState createState() => _TimeRangeFilterTileState();
}

class _TimeRangeFilterTileState extends State<TimeRangeFilterTile> {
  TimeRangeFilters _currentFilter;
  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<TimeRangeFilters>(
        value: _currentFilter,
        onChanged: _changeFilter,
        items: _timeRangeFiltersPayloads
          .map<DropdownMenuItem<TimeRangeFilters>>(_buildDropdownMenuItem)
          .toList(),
      ),
    );
  }

  void _changeFilter(TimeRangeFilters value) {
    if (value != null) {
      setState(() => _currentFilter = value);
      widget.onSort(value);
    }
  }

  List<_TimeRangeFilterPayload> get _timeRangeFiltersPayloads {
    return [
      _TimeRangeFilterPayload(name: _locale.today, filter: TimeRangeFilters.today),
      _TimeRangeFilterPayload(name: _locale.last7days, filter: TimeRangeFilters.week),
      _TimeRangeFilterPayload(name: _locale.last30days, filter: TimeRangeFilters.thisMonth),
      _TimeRangeFilterPayload(name: _locale.year, filter: TimeRangeFilters.thisYear),
      _TimeRangeFilterPayload(name: _locale.wholeTime, filter: TimeRangeFilters.wholeTime),
    ];
  }

  DropdownMenuItem<TimeRangeFilters> _buildDropdownMenuItem(_TimeRangeFilterPayload value) {
    return DropdownMenuItem<TimeRangeFilters>(
      value: value.filter,
      child: Text(value.name),
    );
  }
}

class _TimeRangeFilterPayload {
  final String name;
  final TimeRangeFilters filter;

  _TimeRangeFilterPayload({
    @required this.name,
    @required this.filter,
  })  : assert(name != null),
        assert(filter != null);
}
