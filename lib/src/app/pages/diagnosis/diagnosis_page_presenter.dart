import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

class DiagnosisPagePresenter with ChangeNotifier {
  final PatientRepository _patientRepository;

  Map<DateTime, double> _bloodSugarStatisticSeries;
  TimeRangeFilters _timeRangeFilter = TimeRangeFilters.wholeTime;
  bool _isStatisticLoading = false;
  String _average;
  String _min;
  String _max;

  Map<DateTime, double> get bloodSugarStatistic => _bloodSugarStatisticSeries;
  TimeRangeFilters get timeRangeFilter => _timeRangeFilter;
  bool get isStatisticLoading => _isStatisticLoading;
  String get average => _average ?? '...';
  String get min => _min ?? '...';
  String get max => _max ?? '...';

  DiagnosisPagePresenter() : _patientRepository = GetIt.I.get<UserRepository>(){
    init();
  }

  Future<void> init() async {
    _isStatisticLoading = true;
    notifyListeners();

    final statistic = await _patientRepository.fetchBloodSugarStatistic();
    await _fetchStatisticData(statistic);

    _isStatisticLoading = false;
    notifyListeners();
  }

  Future<void> sortStatisticByTimeFilter(TimeRangeFilters filter) async {
    _isStatisticLoading = true;
    notifyListeners();

    _timeRangeFilter = filter;
    final statistic = await _patientRepository.fetchBloodSugarStatistic(
      TimeRange.getEntityByFilter(filter),
    );
    await _fetchStatisticData(statistic);

    _bloodSugarStatisticSeries = await compute(
      _getBloodSugarStatisticSeries,
      statistic,
    );

    _isStatisticLoading = false;
    notifyListeners();
  }

  Future<void> _fetchStatisticData(List<BloodSugarStatistic> statistic) async {
    final results = await Future.wait([
      compute(_getBloodSugarStatisticSeries, statistic),
      compute(_getAverage, statistic),
      compute(_getMin, statistic),
      compute(_getMax, statistic),
    ]);
    _bloodSugarStatisticSeries = results[0];
    _average = results[1];
    _min = results[2];
    _max = results[3];
  }
}

Map<DateTime, double> _getBloodSugarStatisticSeries(
  List<BloodSugarStatistic> list,
) {
  return Map.fromIterable(
    list,
    key: (e) => e.dateTimeOfMeasure,
    value: (e) => e.bloodSugar,
  );
}

String _getAverage(List<BloodSugarStatistic> list) {
  final sum = list.fold(0.0, (acum, v) => acum + v.bloodSugar);
  final average = sum != 0.0 ? sum / list.length : 0.0;
  return average.toStringAsFixed(2);
}

String _getMin(List<BloodSugarStatistic> list) {
  final min = list.fold(null, (acum, v) {
        if (acum == null || v.bloodSugar < acum) {
          acum = v.bloodSugar;
        }
        return acum;
      }) ?? 0.0;
  return min.toStringAsFixed(2);
}

String _getMax(List<BloodSugarStatistic> list) {
  final max = list.fold(0.0, (acum, v) {
        if (v.bloodSugar > acum) {
          acum = v.bloodSugar;
        }
        return acum;
      }) ?? 0;
  return max.toStringAsFixed(2);
}
