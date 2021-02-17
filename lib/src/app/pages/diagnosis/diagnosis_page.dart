import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';

import 'package:dia_app/src/app/routes.dart' as routes;
import 'package:dia_app/src/data/mock_statistic.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';

part 'widgets/_diagnosis_chart.dart';
part 'widgets/_diagnosis_data.dart';

class DiagnosisPage extends StatelessWidget {
  static const nameRoute = routes.diagnosis;

  static PageRoute<DiagnosisPage> buildPageRoute() {
    return MaterialPageRoute<DiagnosisPage>(
      settings: RouteSettings(name: nameRoute),
      builder: _builder,
    );
  }

  static Widget _builder(BuildContext context) {
    return DiagnosisPage();
  }

  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(locale.diagnostics)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: _DiagnosisChart()),
            Expanded(child: _DiagnosisData()),
          ],
        ),
      ),
    );
  }
}
