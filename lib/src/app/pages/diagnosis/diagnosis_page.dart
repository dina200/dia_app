import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/routes.dart' as routes;
import 'package:dia_app/src/app/widgets/time_range_filter_tile.dart';
import 'package:dia_app/src/app/widgets/line_chart/chart/animated_line_chart.dart';
import 'package:dia_app/src/app/widgets/line_chart/chart/line_chart.dart';
import 'package:dia_app/src/app/widgets/loading_layout.dart';

import 'package:dia_app/src/domain/entities/time_range.dart';


import 'diagnosis_page_presenter.dart';

part 'widgets/_diagnosis_chart.dart';
part 'widgets/_diagnosis_data.dart';

class DiagnosisPage extends StatelessWidget {
  static const nameRoute = routes.diagnosis;

  static PageRoute buildPageRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiagnosisPagePresenter(),
      child: DiagnosisPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);
    final watch = context.watch<DiagnosisPagePresenter>();

    return Scaffold(
      appBar: AppBar(title: Text(locale.diagnostics)),
      body: LoadingLayout(
        isLoading: watch.isStatisticLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TimeRangeFilterTile(
                value: watch.timeRangeFilter,
                onSort: (filter) => _onSort(context, filter),
              ),
              Expanded(child: _DiagnosisChart()),
              Expanded(child: _DiagnosisData()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSort(BuildContext context, TimeRangeFilters filter) async {
    final read = context.read<DiagnosisPagePresenter>();
    await read.sortStatisticByTimeFilter(filter);
  }
}
