import 'dart:async';

import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

class MockUserRepositoryFactory implements UserRepositoryFactory {
  @override
  UserRepository createUserRepository(UserType type) {
    switch(type) {
      case UserType.Patient:
        return MockPatientRepository();
      case UserType.Doctor:
        return MockDoctorRepository();
      default:
        throw AssertionError('This user type do not exist');
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
        docEmail: 'doctor@gmail.com',
      ),
      Patient(
        id: 'Patient9876543211',
        fullName: 'Patient1',
        email: 'patient1@gmail.com',
        docEmail: 'doctor@gmail.com',
      ),
      Patient(
        id: 'Patient9876543212',
        fullName: 'Patient2',
        email: 'patient2@gmail.com',
        docEmail: 'doctor@gmail.com',
      ),
      Patient(
        id: 'Patient9876543213',
        fullName: 'Patient3',
        email: 'patient3@gmail.com',
        docEmail: 'doctor@gmail.com',
      ),
    ];
  }
}

abstract class _MockUserRepository implements UserRepository {
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
      docEmail: 'doctor@gmail.com',
    );
  }
}
