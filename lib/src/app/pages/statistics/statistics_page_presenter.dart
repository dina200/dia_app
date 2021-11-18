import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

class StatisticPagePresenter extends ChangeNotifier {
  final String patientId;

  final UserRepository _patientRepository;

  StatisticPagePresenter(this.patientId)
      : _patientRepository = GetIt.I.get<UserRepository>() {
    init();
  }

  Patient _patient;
  List<BloodSugarStatistic> _bloodSugarStatistic;
  TimeRangeFilters _timeRangeFilter = TimeRangeFilters.wholeTime;
  bool _isPatientLoading = false;
  bool _isStatisticLoading = false;

  Patient get patient => _patient;
  List<BloodSugarStatistic> get bloodSugarStatistic => _bloodSugarStatistic;
  TimeRangeFilters get timeRangeFilter => _timeRangeFilter;
  bool get isUserLoading => _isPatientLoading;
  bool get isStatisticLoading => _isStatisticLoading;
  bool get isStatisticNotEmpty =>
      _bloodSugarStatistic != null && _bloodSugarStatistic.isNotEmpty;

  Future<void> init() async {
    _isPatientLoading = true;
    _isStatisticLoading = true;
    notifyListeners();

    final results = await Future.wait([
      _patientRepository.fetchPatientById(patientId),
      _patientRepository.fetchBloodSugarStatisticByPatientId(patientId),
    ]);

    _patient = results[0];
    _bloodSugarStatistic = results[1];

    _isPatientLoading = false;
    _isStatisticLoading = false;
    notifyListeners();
  }

  Future<void> sortStatisticByTimeFilter(TimeRangeFilters filter) async {
    _isStatisticLoading = true;
    notifyListeners();

    _timeRangeFilter = filter;
    _bloodSugarStatistic = await _patientRepository
        .fetchBloodSugarStatisticByPatientId(patientId, TimeRange.getEntityByFilter(filter));

    _isStatisticLoading = false;
    notifyListeners();
  }
}
