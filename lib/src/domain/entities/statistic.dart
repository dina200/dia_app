import 'dart:ui';

import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

abstract class Statistic {
  final DateTime dateTimeOfMeasure;

  Statistic({DateTime dateTimeOfMeasure})
      : dateTimeOfMeasure = dateTimeOfMeasure ?? DateTime.now();

  int compareTo(Statistic anotherStatistic) {
    if (dateTimeOfMeasure.isAfter(anotherStatistic.dateTimeOfMeasure))  return -1;
    else if (dateTimeOfMeasure.isBefore(anotherStatistic.dateTimeOfMeasure)) return 1;
    else return 0;
  }

  String getDateTime(DiaLocalizations locale) {
    final date = DateFormat.yMMMd(locale.localeName).format(dateTimeOfMeasure);
    final time = DateFormat.Hm(locale.localeName).format(dateTimeOfMeasure);
    return '$date $time';
  }

  String getDate(DiaLocalizations locale) {
    return DateFormat.yMd(locale.localeName).format(dateTimeOfMeasure);
  }

  String getSimpleDateTime() {
    return DateFormat('dd.MM HH:mm').format(dateTimeOfMeasure);
  }
}

class BloodSugarStatistic extends Statistic {
  final double bloodSugar;

  BloodSugarStatistic({
    @required this.bloodSugar,
    DateTime dateTimeOfMeasure,
  })  : assert(bloodSugar != null),
        super(dateTimeOfMeasure: dateTimeOfMeasure);

  BloodSugarDiagnosis get diagnosis {
    if (bloodSugar < 4.1) {
      return BloodSugarDiagnosis.hypoglycemia;
    } else if (bloodSugar > 5.9) {
      return BloodSugarDiagnosis.hyperglycemia;
    }
    return BloodSugarDiagnosis.normal;
  }

  String getFullData(DiaLocalizations locale) {
    final formattedDateTime = getDateTime(locale);
    final dataOfBloodSugar = getBloodSugar(locale);
    final bloodSugarDiagnosis = getDiagnosis(locale);

    return '$formattedDateTime, $dataOfBloodSugar, $bloodSugarDiagnosis';
  }

  String getDiagnosis(DiaLocalizations locale) {
    switch (diagnosis) {
      case BloodSugarDiagnosis.hypoglycemia: return locale.hypoglycemia;
      case BloodSugarDiagnosis.hyperglycemia: return locale.hyperglycemia;
      case BloodSugarDiagnosis.normal: return locale.normal;
      default: return '-';
    }
  }

  String getBloodSugar(DiaLocalizations locale) {
    final dataOfBloodSugar = '${bloodSugar.toStringAsFixed(1).toString()}';
    return '$dataOfBloodSugar ${locale.mmolPerL}';
  }

  Color get color {
    switch (diagnosis) {
      case BloodSugarDiagnosis.hypoglycemia: return Color(0xFFA0C4FF);
      case BloodSugarDiagnosis.normal: return Color(0xFFCAFFBF);
      case BloodSugarDiagnosis.hyperglycemia: return Color(0xFFffadad);
      default: return Color(0xFFFFFFFF);
    }
  }

  String getBriefInfo(DiaLocalizations locale) {
    return '${super.getSimpleDateTime()}, ${getBloodSugar(locale)}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodSugarStatistic &&
          runtimeType == other.runtimeType &&
          dateTimeOfMeasure == other.dateTimeOfMeasure &&
          bloodSugar == other.bloodSugar;

  @override
  int get hashCode => bloodSugar.hashCode;
}

enum BloodSugarDiagnosis {
  hypoglycemia,
  hyperglycemia,
  normal,
}
