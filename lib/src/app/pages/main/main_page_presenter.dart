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
  final UserRepository _userRepository;

  User _user;
  List<BloodSugarStatistic> _bloodSugarStatistic;
  TimeRangeFilters _timeRangeFilter = TimeRangeFilters.wholeTime;
  bool _isUserLoading = false;
  bool _isLogOutLoading = false;
  bool _isSavingData = false;
  bool _isStatisticLoading = false;

  User get user => _user;
  List<BloodSugarStatistic> get bloodSugarStatistic => _bloodSugarStatistic;
  TimeRangeFilters get timeRangeFilter => _timeRangeFilter;
  bool get isUserLoading => _isUserLoading;
  bool get isLogOutLoading => _isLogOutLoading;
  bool get isSavingData => _isSavingData;
  bool get isStatisticLoading => _isStatisticLoading;
  bool get isStatisticNotEmpty =>
      _bloodSugarStatistic != null && _bloodSugarStatistic.isNotEmpty;

  MainPagePresenter(this._context)
      : _authRepository = GetIt.I.get<AuthRepository>(),
        _userRepository = GetIt.I.get<UserRepository>() {
    init();
  }

  Future<void> init() async {
    _isUserLoading = true;
    _isStatisticLoading = true;
    notifyListeners();

    final results = await Future.wait([
      _userRepository.fetchUser(),
      _userRepository.fetchBloodSugarStatistic(),
    ]);

    _user = results[0];
    _bloodSugarStatistic = results[1];

    _isUserLoading = false;
    _isStatisticLoading = false;
    notifyListeners();
  }

  Future<void> saveUserData(String name, String docEmail) async {
    _isUserLoading = true;
    notifyListeners();

    await _userRepository.changeUserData(name, docEmail);
    _user = await _userRepository.fetchUser();

    _isUserLoading = false;
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

    await _userRepository.saveBloodSugarData(
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
    _bloodSugarStatistic = await _userRepository
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
        'mailto:${_user.docsEmail ?? ''}?subject=${locale.bloodSugarStatistic}: ${user.fullName}&body=$statistic');
  }

  Future<void> sendUserId() async {
    final locale = DiaLocalizations.of(_context);
    await launch(
      'mailto:${_user.docsEmail ?? ''}?subject=${user.fullName}&body=${locale.sendIdText} ${user.id}');
  }
}

FutureOr<String> _getStatisticToStr(Map<String, dynamic> data) {
  return (data['statistic'] as List<BloodSugarStatistic>).fold(
    '',
    (prevValue, value) => '$prevValue ${value.getBriefInfo(data['locale'])}\n',
  );
}
