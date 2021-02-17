import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'package:dia_app/src/data/mock_statistic.dart';
import 'package:dia_app/src/app/widgets/time_range_filter_tile.dart';

part 'widgets/_statistics_list.dart';

class StatisticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TimeRangeFilterTile(onSort: _onSort),
        Expanded(child: _StatisticsList())
      ],
    );
  }

  void _onSort(_) {
    //TODO: sort statistic by time range
  }
}
