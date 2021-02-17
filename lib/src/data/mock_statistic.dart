import 'package:dia_app/src/domain/entities/statistic.dart';

//TODO: required to remove
final List<BloodSugarStatistic> mockStatisticList = [
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay)), bloodSugar: 6.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 2)), bloodSugar: 3.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 3)), bloodSugar: 2.33),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 4)), bloodSugar: 2.32),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 5)), bloodSugar: 1.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 6)), bloodSugar: 4.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 7)), bloodSugar: 5.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 8)), bloodSugar: 4.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 9)), bloodSugar: 6.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 10)), bloodSugar: 4.5),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 10)), bloodSugar: 4.5),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 11)), bloodSugar: 2.1),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 12)), bloodSugar: 6.6),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 13)), bloodSugar: 4.4),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 14)), bloodSugar: 7.7),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 15)), bloodSugar: 3.4),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 16)), bloodSugar: 2.23),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 17)), bloodSugar: 8.3),
  BloodSugarStatistic(dateTimeOfMeasure: DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 18)), bloodSugar: 2.13),
];

final Map<DateTime, double> mockStatisticSeries = Map.fromIterable(
  mockStatisticList,
  key: (e) => e.dateTimeOfMeasure,
  value: (e) => e.bloodSugar,
);

double getMinBloodSugarValue() {
  return mockStatisticList.fold(null, (acum, v) {
    if (acum == null || v.bloodSugar < acum) {
      acum = v.bloodSugar;
    }
    return acum;
  }) ?? 0.0;
}

double getMaxBloodSugarValue() {
  return mockStatisticList.fold(0, (acum, v){
    if(acum != null && v.bloodSugar > acum) {
      acum = v.bloodSugar;
    }
    return acum;
  }) ?? 0.0;
}

BloodSugarStatistic getAverageBloodSugarStatistic() {
  double averageValueOfBloodSugar = mockStatisticList.fold(0.0, (acum, v) {
    return acum + v.bloodSugar;
  });
  averageValueOfBloodSugar = averageValueOfBloodSugar != 0.0
      ? averageValueOfBloodSugar / mockStatisticList.length
      : 0.0;
  return BloodSugarStatistic(
    dateTimeOfMeasure: DateTime.now(),
    bloodSugar: averageValueOfBloodSugar,
  );
}
