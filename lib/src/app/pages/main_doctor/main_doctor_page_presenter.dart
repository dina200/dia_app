import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class MainDoctorPagePresenter with ChangeNotifier {
  final AuthRepository _authRepository;
  final DoctorRepository _doctorRepository;

  Doctor _doctor;
  List<Patient> _patients;
  bool _isLogOutLoading = false;
  bool _isDoctorLoading = false;
  bool _isPatientsLoading = false;

  Doctor get doctor => _doctor;
  List<Patient> get patients => _patients;
  bool get isLogOutLoading => _isLogOutLoading;
  bool get isDoctorLoading => _isDoctorLoading;
  bool get isPatientsLoading => _isPatientsLoading;

  MainDoctorPagePresenter()
      : _authRepository = GetIt.I.get<AuthRepository>(),
        _doctorRepository = GetIt.I.get<UserRepository>() {
    init();
  }

  Future<void> init() async {
    _isDoctorLoading = true;
    _isPatientsLoading = true;
    notifyListeners();

    final results = await Future.wait([
      _doctorRepository.fetchDoctor(),
      _doctorRepository.fetchPatients(),
    ]);

    _doctor = results[0];
    _patients = results[1];

    _isDoctorLoading = false;
    _isPatientsLoading = false;
    notifyListeners();
  }

  Future<void> addPatient(String patientId) async {
    _isPatientsLoading = true;
    notifyListeners();

    await _doctorRepository.addPatient(patientId);
    _patients = await _doctorRepository.fetchPatients();

    _isPatientsLoading = false;
    notifyListeners();
  }

  Future<void> logOut() async {
    _isLogOutLoading = true;
    notifyListeners();

    await _authRepository.logOut();

    _isLogOutLoading = false;
    notifyListeners();
  }
}