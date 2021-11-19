import 'package:dia_app/src/data/mock_repositories/mock_auth_repository.dart';
import 'package:dia_app/src/data/mock_repositories/mock_user_repository.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

main() {
  AuthRepository _authRepository;
  setUp(() {
    _authRepository = MockAuthRepository();
    GetIt.I.registerSingleton<UserRepositoryFactory>(
      MockUserRepositoryFactory(),
    );
  });

  tearDown(() {
    GetIt.I.unregister<UserRepositoryFactory>();
  });

  group('AuthRepository', () {
    test('init', () async {
      expect(UserType.Patient, await _authRepository.init());
    });

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
