import 'dart:ui';

import 'package:dia_app/src/domain/entities/statistic.dart';

import 'package:flutter_test/flutter_test.dart';

main() {
  final bloodSugarStatistic = BloodSugarStatistic(
    bloodSugar: 5.0,
    dateTimeOfMeasure: DateTime(2021, 10, 11),
  );

  final bloodSugarStatisticList = [
    BloodSugarStatistic(
      bloodSugar: 3.0,
      dateTimeOfMeasure: DateTime(2021, 10, 10),
    ),
    BloodSugarStatistic(
      bloodSugar: 5.0,
      dateTimeOfMeasure: DateTime(2021, 10, 11),
    ),
    BloodSugarStatistic(
      bloodSugar: 6.0,
      dateTimeOfMeasure: DateTime(2021, 10, 12),
    ),
  ];

  test(
    'Statistic type : BloodSugarStatistic is Statistic',
    () {
      expect(bloodSugarStatistic, isA<Statistic>());
    },
  );

  test(
    'Statistic : DateTime Formatting',
    () {
      final expected = '11.10 00:00';
      expect(bloodSugarStatistic.getSimpleDateTime(), expected);
    },
  );

  test(
    'BloodSugarStatistic : diagnosis',
    () {
      expect(bloodSugarStatisticList[0].diagnosis, BloodSugarDiagnosis.hypoglycemia);
      expect(bloodSugarStatisticList[1].diagnosis, BloodSugarDiagnosis.normal);
      expect(bloodSugarStatisticList[2].diagnosis, BloodSugarDiagnosis.hyperglycemia);
    },
  );

  test(
    'BloodSugarStatistic : color of item',
        () {
      expect(bloodSugarStatisticList[0].color, Color(0xFFA0C4FF));
      expect(bloodSugarStatisticList[1].color, Color(0xFFCAFFBF));
      expect(bloodSugarStatisticList[2].color, Color(0xFFffadad));
    },
  );
}
