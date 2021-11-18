import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';

abstract class UserRepositoryFactory {
  UserRepository createUserRepository(UserRole type);
}

abstract class UserRepository {
  Future<Doctor> fetchDoctor();

  Future<Patient> fetchPatientById(String patientId);

  Future<List<BloodSugarStatistic>> fetchBloodSugarStatisticByPatientId(
    String patientId, [
    TimeRange timeRange,
  ]);
}

abstract class PatientRepository extends UserRepository {
  Future<void> changePatientData(String name, String docEmail);

  Future<Patient> fetchCurrentPatient();

  Future<void> saveBloodSugarData(BloodSugarStatistic data);

  Future<List<BloodSugarStatistic>> fetchBloodSugarStatistic([
    TimeRange timeRange,
  ]);
}

abstract class DoctorRepository extends UserRepository {
  Future<void> addPatient(String patientId);

  Future<List<Patient>> fetchPatients();
}
