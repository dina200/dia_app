import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

abstract class Statistic {
  final DateTime timeMeasure;

  Statistic(this.timeMeasure) : assert(timeMeasure != null);

  int compareTo(Statistic anotherStatistic) {
    if (timeMeasure.isAfter(anotherStatistic.timeMeasure)) {
      return -1;
    } else if (timeMeasure.isBefore(anotherStatistic.timeMeasure)) {
      return 1;
    } else {
      return 0;
    }
  }
}

class SugarInBloodStatistic extends Statistic {
  final double bloodSugar;

  SugarInBloodStatistic({
    @required DateTime timeMeasure,
    @required this.bloodSugar,
  })  : assert(bloodSugar != null),
        super(timeMeasure);

  BloodSugarDiagnosis get diagnosis {
    if (bloodSugar < 4.1) {
      return BloodSugarDiagnosis.hypoglycemia;
    } else if (bloodSugar > 5.9) {
      return BloodSugarDiagnosis.hyperglycemia;
    }
    return BloodSugarDiagnosis.normal;
  }

  String getFullData(DiaLocalizations locale) {
    String bloodSugarDiagnosis = _getDiagnosisByBloodSugar(locale);
    final date = DateFormat('dd.MM.yyyy HH:mm').format(timeMeasure);
    final dataOfBloodSugar = '${bloodSugar.toStringAsFixed(1).toString()}';

    return '$date, $dataOfBloodSugar ${locale.mmolPerL}, $bloodSugarDiagnosis';
  }

  String _getDiagnosisByBloodSugar(DiaLocalizations locale) {
    switch (diagnosis) {
      case BloodSugarDiagnosis.hypoglycemia: return locale.hypoglycemia;
      case BloodSugarDiagnosis.hyperglycemia: return locale.hyperglycemia;
      case BloodSugarDiagnosis.normal: return locale.normal;
      default: return '-';
    }
  }
}

enum BloodSugarDiagnosis {
  hypoglycemia,
  hyperglycemia,
  normal,
}
