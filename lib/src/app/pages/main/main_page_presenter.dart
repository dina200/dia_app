import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

class MainPagePresenter with ChangeNotifier {
  final BuildContext _context;
  final AuthRepository _authRepository;
  final PatientRepository _patientRepository;

  Patient _patient;
  List<BloodSugarStatistic> _bloodSugarStatistic;
  TimeRangeFilters _timeRangeFilter = TimeRangeFilters.wholeTime;
  bool _isPatientLoading = false;
  bool _isLogOutLoading = false;
  bool _isSavingData = false;
  bool _isStatisticLoading = false;

  Patient get patient => _patient;
  List<BloodSugarStatistic> get bloodSugarStatistic => _bloodSugarStatistic;
  TimeRangeFilters get timeRangeFilter => _timeRangeFilter;
  bool get isUserLoading => _isPatientLoading;
  bool get isLogOutLoading => _isLogOutLoading;
  bool get isSavingData => _isSavingData;
  bool get isStatisticLoading => _isStatisticLoading;
  bool get isStatisticNotEmpty =>
      _bloodSugarStatistic != null && _bloodSugarStatistic.isNotEmpty;

  MainPagePresenter(this._context)
      : _authRepository = GetIt.I.get<AuthRepository>(),
        _patientRepository = GetIt.I.get<UserRepository>() {
    init();
  }

  Future<void> init() async {
    _isPatientLoading = true;
    _isStatisticLoading = true;
    notifyListeners();

    final results = await Future.wait([
      _patientRepository.fetchCurrentPatient(),
      _patientRepository.fetchBloodSugarStatistic(),
    ]);

    _patient = results[0];
    _bloodSugarStatistic = results[1];

    _isPatientLoading = false;
    _isStatisticLoading = false;
    notifyListeners();
  }

  Future<void> saveUserData(String name, String docEmail) async {
    _isPatientLoading = true;
    notifyListeners();

    await _patientRepository.changePatientData(name, docEmail);
    _patient = await _patientRepository.fetchCurrentPatient();

    _isPatientLoading = false;
    notifyListeners();
  }

  Future<void> logOut() async {
    _isLogOutLoading = true;
    notifyListeners();

    await _authRepository.logOut();

    _isLogOutLoading = false;
    notifyListeners();
  }

  Future<void> saveBloodSugarData(String value) async {
    _isSavingData = true;
    notifyListeners();

    await _patientRepository.saveBloodSugarData(
      BloodSugarStatistic(bloodSugar: double.parse(value)),
    );

    _isSavingData = false;
    notifyListeners();
    await sortStatisticByTimeFilter(timeRangeFilter);
    notifyListeners();
  }

  Future<void> sortStatisticByTimeFilter(TimeRangeFilters filter) async {
    _isStatisticLoading = true;
    notifyListeners();

    _timeRangeFilter = filter;
    _bloodSugarStatistic = await _patientRepository
        .fetchBloodSugarStatistic(TimeRange.getEntityByFilter(filter));

    _isStatisticLoading = false;
    notifyListeners();
  }

  Future<void> sendStatistic() async {
    final locale = DiaLocalizations.of(_context);
    final statistic = await compute(_getStatisticToStr, {
      'locale': locale,
      'statistic': _bloodSugarStatistic,
    });
    await launch(
        'mailto:${_patient.docEmail ?? ''}?subject=${locale.bloodSugarStatistic}: ${patient.fullName}&body=$statistic');
  }

  Future<void> sendUserId() async {
    final locale = DiaLocalizations.of(_context);
    await launch(
      'mailto:${_patient.docEmail ?? ''}?subject=${patient.fullName}&body=${locale.sendIdText} ${patient.id}');
  }
}

FutureOr<String> _getStatisticToStr(Map<String, dynamic> data) {
  return (data['statistic'] as List<BloodSugarStatistic>).fold(
    '',
    (prevValue, value) => '$prevValue ${value.getBriefInfo(data['locale'])}\n',
  );
}
