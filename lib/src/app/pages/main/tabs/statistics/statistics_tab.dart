import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/pages/main/main_page_presenter.dart';
import 'package:dia_app/src/app/widgets/loading_layout.dart';
import 'package:dia_app/src/app/widgets/time_range_filter_tile.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';

part 'widgets/_statistics_list.dart';

class StatisticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MainPagePresenter>();
    return LoadingLayout(
      isLoading: watch.isStatisticLoading,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TimeRangeFilterTile(
            initialValue: watch.timeRangeFilter,
            onSort: (filter) => _onSort(context, filter),
          ),
          Expanded(child: _StatisticsList())
        ],
      ),
    );
  }

  Future<void> _onSort(BuildContext context, TimeRangeFilters filter) async {
    await context.read<MainPagePresenter>().sortStatisticByTimeFilter(filter);
  }
}
