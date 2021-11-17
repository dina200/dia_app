import 'package:dia_app/src/data/mock_repositories/mock_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  MockDoctorRepository _userRepository;

  setUp(() {
    _userRepository = MockDoctorRepository();
  });
}