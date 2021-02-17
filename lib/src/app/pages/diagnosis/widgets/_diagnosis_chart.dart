part of '../diagnosis_page.dart';

class _DiagnosisChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = DiaLocalizations.of(context);

    LineChart chart = LineChart.fromDateTimeMaps(
      [mockStatisticSeries],
      [theme.primaryColor],
      [locale.mmolPerL],
    );

    return SizedBox.expand(
      child: AnimatedLineChart(chart),
    );
  }
}
