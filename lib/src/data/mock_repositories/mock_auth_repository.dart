import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

class MockAuthRepository extends AuthRepository {
  @override
  Future<bool> get isLoggedIn async {
    return true;
  }

  @override
  Future<UserRole> get role async => UserRole.Patient;

  @override
  Future<void> loginWithGoogle() async {}

  @override
  Future<void> loginWithGoogleAsDoctor() async {}

  @override
  Future<void> logOut() async {}
}
