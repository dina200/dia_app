part of '../diagnosis_page.dart';

class _DiagnosisChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = DiaLocalizations.of(context);
    final watch = context.watch<DiagnosisPagePresenter>();

    if(watch.bloodSugarStatistic == null) {
      return SizedBox();
    } else if(watch.bloodSugarStatistic.isEmpty) {
      return Center(child: Text(locale.noData));
    }

    LineChart chart = LineChart.fromDateTimeMaps(
      [watch.bloodSugarStatistic],
      [theme.primaryColor],
      [locale.mmolPerL],
    );
    return SizedBox.expand(
      child: AnimatedLineChart(chart),
    );
  }
}
