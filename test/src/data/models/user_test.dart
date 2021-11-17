import 'package:dia_app/src/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final patient = Patient(
    id: 'Patient987654321',
    fullName: 'Patient',
    email: 'patient@gmail.com',
    docsEmail: 'doctor@gmail.com',
  );

  final doctor = Doctor(
    id: 'Doctor987654321',
    fullName: 'Doctor',
    email: 'doctor@gmail.com',
    patientIds: [
      'Patient98765432',
    ],
  );

  test(
    'User type : Patient and Doctor are User',
    () {
      expect(patient, isA<User>());
      expect(doctor, isA<User>());
    },
  );
}
