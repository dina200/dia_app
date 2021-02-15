import 'package:meta/meta.dart';

import 'package:intl/intl.dart';

abstract class Statistic {
  final DateTime timeMeasure;

  Statistic(this.timeMeasure) : assert(timeMeasure != null);

  int compareTo(Statistic statistic) {
    if (timeMeasure.isAfter(statistic.timeMeasure)) {
      return -1;
    } else if (timeMeasure.isBefore(statistic.timeMeasure)) {
      return 1;
    } else {
      return 0;
    }
  }
}

class SugarInBloodStatistic extends Statistic {
  final double sugarInBlood;

  SugarInBloodStatistic({
    @required DateTime timeMeasure,
    @required this.sugarInBlood,
  })  : assert(sugarInBlood != null),
        super(timeMeasure);

  SugarInBloodDiagnosis get diagnosis {
    if (sugarInBlood < 4.1) {
      return SugarInBloodDiagnosis.hypoglycemia;
    } else if (sugarInBlood > 5.9) {
      return SugarInBloodDiagnosis.hyperglycemia;
    }
    return SugarInBloodDiagnosis.normal;
  }

  String toString() {
    return '${DateFormat('dd.MM.yyyy HH:mm').format(timeMeasure)}, ${sugarInBlood.toStringAsFixed(1).toString()} mmol/L, $diagnosis';
  }
}

enum SugarInBloodDiagnosis {
  hypoglycemia,
  hyperglycemia,
  normal,
}
