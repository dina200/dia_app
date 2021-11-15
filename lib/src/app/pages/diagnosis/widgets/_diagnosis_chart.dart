part of '../diagnosis_page.dart';

class _DiagnosisChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = DiaLocalizations.of(context);
    final watch = context.watch<DiagnosisPagePresenter>();

    final statistic = watch.bloodSugarStatistic.entries.map(
            (entry) {
          return LineChartModel(date: entry.key, amount: entry.value);
        }
    ).toList();
    if (statistic == null) {
      return SizedBox();
    } else if (statistic.isEmpty || statistic.length == 1) {
      return Center(child: Text(locale.noData));
    }

    final size = MediaQuery.of(context).size;
    return SizedBox.expand(
      child: LineChart(

        data: statistic,
        linePaint: Paint()
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke
          ..color = theme.primaryColor,
        width: size.width,
        height: size.height / 3,
      ),
    );
  }
}
