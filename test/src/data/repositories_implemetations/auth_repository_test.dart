import 'package:dia_app/src/data/mock_repositories/mock_auth_repository.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  MockAuthRepository _authRepository;

  setUp(() {
    _authRepository = MockAuthRepository();
  });

  group('AuthRepository', () {
    test('isLoggedIn', () async {
      expect(true, await _authRepository.isLoggedIn);
    });

    test(
      'role',
      () async {
        expect(UserRole.Patient, equals(await _authRepository.role));
      },
    );

    test(
      'logOut',
      () async {
        final isLogout = _authRepository.logOut();
        expect(true, equals(await isLogout));
      },
    );
  });
}
