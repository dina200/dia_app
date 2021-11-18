import 'package:dia_app/src/data/mock_repositories/mock_user_repository.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  UserRepositoryFactory _userRepositoryFactory;
  PatientRepository _patientRepository;
  DoctorRepository _doctorRepository;

  setUp(() {
    _userRepositoryFactory = MockUserRepositoryFactory();
    _patientRepository = MockPatientRepository();
    _doctorRepository = MockDoctorRepository();
  });

  group('UserRepositoryFactory', (){
    test('create PatientRepository', ()  {
      final repository = _userRepositoryFactory.createUserRepository(UserType.Patient);
      expect(repository, isA<PatientRepository>());
    });

    test('create DoctorRepository', ()  {
      final repository = _userRepositoryFactory.createUserRepository(UserType.Doctor);
      expect(repository, isA<DoctorRepository>());
    });
  });

  group('PatientRepository', () {
    test('fetchBloodSugarStatistic', () async {
      final statistic = await _patientRepository.fetchBloodSugarStatistic();
      expect(
        true,
        listEquals(
          statistic,
          [
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
          ],
        ),
      );
    });

    test(
      'fetchCurrentPatient',
      () async {
        final patient = await _patientRepository.fetchCurrentPatient();
        expect(
          patient,
          equals(
            Patient(
              id: 'Patient987654321',
              fullName: 'Patient',
              email: 'patient@gmail.com',
              docsEmail: 'doctor@gmail.com',
            ),
          ),
        );
      },
    );
  });

  group('DoctorRepository', () {
    test('fetchPatients', () async {
      final statistic = await _doctorRepository.fetchPatients();
      expect(
        statistic,
        equals(
          [
            Patient(
              id: 'Patient987654321',
              fullName: 'Patient',
              email: 'patient@gmail.com',
              docsEmail: 'doctor@gmail.com',
            ),
          ],
        ),
      );
    });
  });

  group('UserRepository', () {
    test('fetchDoctor', () async {
      final patient = await _patientRepository.fetchDoctor();
      expect(
        patient,
        equals(
          Doctor(
            id: 'Doctor987654321',
            fullName: 'Doctor',
            email: 'doctor@gmail.com',
            patientIds: [
              'Patient987654321',
            ],
          ),
        ),
      );
    });

    test('fetchBloodSugarStatisticByPatientId', () async {
      final statistic = await _doctorRepository.fetchBloodSugarStatisticByPatientId('Patient987654321');
      expect(
        true,
        listEquals(
          statistic,
          [
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
          ],
        ),
      );
    });

    test('fetchPatientById', () async {
      final patient = await _patientRepository.fetchPatientById('Patient987654321');
      expect(
        patient,
        equals(
          Patient(
            id: 'Patient987654321',
            fullName: 'Patient',
            email: 'patient@gmail.com',
            docsEmail: 'doctor@gmail.com',
          ),
        ),
      );
    });
  });
}
