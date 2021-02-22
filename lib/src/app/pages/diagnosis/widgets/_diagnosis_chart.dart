part of '../diagnosis_page.dart';

class _DiagnosisChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = DiaLocalizations.of(context);
    final watch = context.watch<DiagnosisPagePresenter>();

    final statistic = watch.bloodSugarStatistic;
    if (statistic == null) {
      return SizedBox();
    } else if (statistic.isEmpty || statistic.length == 1) {
      return Center(child: Text(locale.noData));
    }

    LineChart chart = LineChart.fromDateTimeMaps(
      [statistic],
      [theme.primaryColor],
      [locale.mmolPerL],
    );
    return SizedBox.expand(
      child: AnimatedLineChart(chart),
    );
  }
}
