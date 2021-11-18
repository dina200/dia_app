import 'dart:async';

import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

class MockUserRepositoryFactory extends UserRepositoryFactory {
  @override
  UserRepository createUserRepository(UserRole type) {
    switch(type) {
      case UserRole.Patient:
        return MockPatientRepository();
      case UserRole.Doctor:
        return MockDoctorRepository();
      default:
        return MockPatientRepository();
    }
  }
}

class MockPatientRepository extends _MockUserRepository
    implements PatientRepository {
  @override
  Future<void> changePatientData(String name, String docEmail) async {}

  @override
  Future<List<BloodSugarStatistic>> fetchBloodSugarStatistic([
    TimeRange timeRange,
  ]) async {
    return fetchBloodSugarStatisticByPatientId('Patient987654321');
  }

  @override
  Future<Patient> fetchCurrentPatient() async {
    return fetchPatientById('Patient987654321');
  }

  @override
  Future<void> saveBloodSugarData(BloodSugarStatistic data) async {}
}

class MockDoctorRepository extends _MockUserRepository
    implements DoctorRepository {
  @override
  Future<void> addPatient(String patientId) async {}

  @override
  Future<List<Patient>> fetchPatients() async {
    return [
      Patient(
        id: 'Patient987654321',
        fullName: 'Patient',
        email: 'patient@gmail.com',
        docsEmail: 'doctor@gmail.com',
      ),
    ];
  }
}

abstract class _MockUserRepository extends UserRepository {
  @override
  Future<List<BloodSugarStatistic>> fetchBloodSugarStatisticByPatientId(
      String patientId,
      [TimeRange timeRange]) async {
    return [
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
  }

  @override
  Future<Doctor> fetchDoctor() async {
    return Doctor(
      id: 'Doctor987654321',
      fullName: 'Doctor',
      email: 'doctor@gmail.com',
      patientIds: [
        'Patient987654321',
      ],
    );
  }

  @override
  Future<Patient> fetchPatientById(String patientId) async {
    return Patient(
      id: 'Patient987654321',
      fullName: 'Patient',
      email: 'patient@gmail.com',
      docsEmail: 'doctor@gmail.com',
    );
  }
}
