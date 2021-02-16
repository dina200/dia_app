part of '../statistics_tab.dart';

class _StatisticsList extends StatefulWidget {
  @override
  _StatisticsListState createState() => _StatisticsListState();
}

class _StatisticsListState extends State<_StatisticsList> {

  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (context, i) => SizedBox(height: 1.0),
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final item = list[index];
    return Material(
      color: item.color,
      child: ListTile(
        subtitle: Text(item.formattedDateTime),
        title: Text(item.getBloodSugar(_locale)),
        trailing: Text(item.getDiagnosis(_locale)),
      ),
    );
  }
}

//TODO: required to remove
final List<SugarInBloodStatistic> list = [
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay)), bloodSugar: 24.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 2)), bloodSugar: 26.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 3)), bloodSugar: 2.33),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 4)), bloodSugar: 2.32),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 5)), bloodSugar: 1.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 6)), bloodSugar: 4.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 7)), bloodSugar: 5.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 8)), bloodSugar: 13.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 9)), bloodSugar: 6.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 10)), bloodSugar: 4.5),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 11)), bloodSugar: 2.1),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 12)), bloodSugar: 6.6),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 13)), bloodSugar: 4.4),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 14)), bloodSugar: 7.7),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 15)), bloodSugar: 3.4),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 16)), bloodSugar: 2.23),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 17)), bloodSugar: 8.3),
  SugarInBloodStatistic(timeMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 18)), bloodSugar: 2.13),
];
