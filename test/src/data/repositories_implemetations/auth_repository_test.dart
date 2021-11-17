import 'package:dia_app/src/data/mock_repositories/mock_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  MockAuthRepository _authRepository;

  setUp(() {
    _authRepository = MockAuthRepository();
  });
}