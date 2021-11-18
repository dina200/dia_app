import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

class MockAuthRepository extends AuthRepository {
  @override
  Future<bool> get isLoggedIn async {
    return true;
  }

  @override
  Future<UserType> get userType async => UserType.Patient;

  @override
  Future<void> loginWithGoogleAsPatient() async {
    super.loginWithGoogleAsPatient();
  }

  @override
  Future<void> loginWithGoogleAsDoctor() async {
    super.loginWithGoogleAsDoctor();
  }

  @override
  Future<void> logOut() async {
    super.logOut();
  }
}
