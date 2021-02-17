import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'package:dia_app/src/data/mock_statistic_list.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';

part 'widgets/_statistics_list.dart';
part 'widgets/_time_range_filter_tile.dart';

class StatisticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TimeRangeFilterTile(onSort: _onSort),
        Expanded(child: _StatisticsList())
      ],
    );
  }

  void _onSort(_) {
    //TODO: sort statistic by time range
  }
}
