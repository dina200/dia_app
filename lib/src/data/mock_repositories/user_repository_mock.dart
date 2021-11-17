import 'dart:async';

import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

class MockPatientRepository extends _MockUserRepository
    implements PatientRepository {
  @override
  Future<void> changePatientData(String name, String docEmail) {
    // TODO: implement changePatientData
    throw UnimplementedError();
  }

  @override
  Future<List<BloodSugarStatistic>> fetchBloodSugarStatistic([TimeRange timeRange]) {
    // TODO: implement fetchBloodSugarStatistic
    throw UnimplementedError();
  }

  @override
  Future<Patient> fetchCurrentPatient() {
    // TODO: implement fetchCurrentPatient
    throw UnimplementedError();
  }

  @override
  Future<void> saveBloodSugarData(BloodSugarStatistic data) {
    // TODO: implement saveBloodSugarData
    throw UnimplementedError();
  }
}

class MockDoctorRepository extends _MockUserRepository
    implements DoctorRepository {
  @override
  Future<void> addPatient(String patientId) {
    // TODO: implement addPatient
    throw UnimplementedError();
  }

  @override
  Future<List<Patient>> fetchPatients() {
    // TODO: implement fetchPatients
    throw UnimplementedError();
  }
}

abstract class _MockUserRepository extends UserRepository {
  @override
  Future<List<BloodSugarStatistic>> fetchBloodSugarStatisticByPatientId(String patientId, [TimeRange timeRange]) {
    // TODO: implement fetchBloodSugarStatisticByPatientId
    throw UnimplementedError();
  }

  @override
  Future<Doctor> fetchDoctor() {
    // TODO: implement fetchDoctor
    throw UnimplementedError();
  }

  @override
  Future<Patient> fetchPatientById(String patientId) {
    // TODO: implement fetchPatientById
    throw UnimplementedError();
  }

}
