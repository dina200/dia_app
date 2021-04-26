abstract class AuthRepository {
  Future<bool> get isLoggedIn;

  Future<int> get role;

  Future<void> loginWithGoogle();

  Future<void> loginWithGoogleAsDoctor();

  Future<bool> logOut();
}
