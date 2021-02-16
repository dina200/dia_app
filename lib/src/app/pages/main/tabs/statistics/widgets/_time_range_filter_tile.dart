part of '../statistics_tab.dart';

typedef SortByTimeRangeCallback = void Function(TimeRangeFilters filter);

class _TimeRangeFilterTile extends StatefulWidget {
  final SortByTimeRangeCallback onSort;

  const _TimeRangeFilterTile({
    Key key,
    @required this.onSort,
  })  : assert(onSort != null),
        super(key: key);

  @override
  _TimeRangeFilterTileState createState() => _TimeRangeFilterTileState();
}

class _TimeRangeFilterTileState extends State<_TimeRangeFilterTile> {
  TimeRangeFilters _currentFilter = TimeRangeFilters.values.first;

  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<TimeRangeFilters>(
        value: _currentFilter,
        onChanged: _changeFilter,
        items: _filtersPayloads
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

  List<_FilterPayload> get _filtersPayloads {
    return [
      _FilterPayload(name: _locale.today, filter: TimeRangeFilters.today),
      _FilterPayload(name: _locale.last7days, filter: TimeRangeFilters.week),
      _FilterPayload(name: _locale.last30days, filter: TimeRangeFilters.thisMonth),
      _FilterPayload(name: _locale.year, filter: TimeRangeFilters.thisYear),
      _FilterPayload(name: _locale.wholeTime, filter: TimeRangeFilters.wholeTime),
    ];
  }

  DropdownMenuItem<TimeRangeFilters> _buildDropdownMenuItem(_FilterPayload value) {
    return DropdownMenuItem<TimeRangeFilters>(
      value: value.filter,
      child: Text(value.name),
    );
  }
}

class _FilterPayload {
  final String name;
  final TimeRangeFilters filter;

  _FilterPayload({
    @required this.name,
    @required this.filter,
  })  : assert(name != null),
        assert(filter != null);
}
