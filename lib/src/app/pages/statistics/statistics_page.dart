import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/widgets/loading_layout.dart';
import 'package:dia_app/src/app/widgets/time_range_filter_tile.dart';
import 'package:dia_app/src/app/pages/statistics/statistics_page_presenter.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/app/routes.dart' as routes;


part 'widgets/_statistics_list.dart';

class StatisticsPage extends StatefulWidget {
  static const nameRoute = routes.statistic;

  static PageRoute buildPageRoute(String patientId) {
    return MaterialPageRoute(
      settings: RouteSettings(name: nameRoute),
      builder: (context) => _builder(context, patientId),
    );
  }

  static Widget _builder(BuildContext context, String patientId) {
    return ChangeNotifierProvider(
        create: (context) => StatisticPagePresenter(patientId),
        child: StatisticsPage());
  }

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  StatisticPagePresenter get _watch => context.watch<StatisticPagePresenter>();
  StatisticPagePresenter get _read => context.read<StatisticPagePresenter>();

  @override
  Widget build(BuildContext context) {
    return LoadingLayout(
      isLoading: _watch.isStatisticLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_watch.patient?.fullName ?? ''),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TimeRangeFilterTile(
              value: _watch.timeRangeFilter,
              onSort: (filter) => _onSort(context, filter),
            ),
            Expanded(child: _StatisticsList())
          ],
        ),
      ),
    );
  }

  Future<void> _onSort(BuildContext context, TimeRangeFilters filter) async {
    await _read.sortStatisticByTimeFilter(filter);
  }
}
