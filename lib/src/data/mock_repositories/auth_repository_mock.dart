import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

class AuthRepositoryMock extends AuthRepository {
  @override
  // TODO: implement isLoggedIn
  Future<bool> get isLoggedIn => throw UnimplementedError();

  @override
  Future<bool> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> loginWithGoogleAsDoctor() {
    // TODO: implement loginWithGoogleAsDoctor
    throw UnimplementedError();
  }

  @override
  // TODO: implement role
  Future<UserRole> get role => throw UnimplementedError();

}
