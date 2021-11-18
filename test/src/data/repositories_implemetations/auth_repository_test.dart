import 'package:dia_app/src/data/mock_repositories/mock_auth_repository.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  AuthRepository _authRepository;
  setUp(() {
    _authRepository = MockAuthRepository();
  });

  group('AuthRepository', () {
    test('isLoggedIn', () async {
      expect(true, await _authRepository.isLoggedIn);
    });

    test(
      'userType',
      () async {
        expect(UserType.Patient, equals(await _authRepository.userType));
      },
    );
  });
}
