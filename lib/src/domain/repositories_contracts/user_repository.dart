import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> changePatientData(String name, String docEmail);

  Future<Patient> fetchPatient();

  Future<void> saveBloodSugarData(BloodSugarStatistic data);

  Future<List<BloodSugarStatistic>> fetchBloodSugarStatistic([
    TimeRange timeRange,
  ]);

  Future<Doctor> fetchDoctor();

  Future<void> addPatient(String patientId);

  Future<List<Patient>> fetchPatients();
}
