import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/device/utils/google_service.dart';
import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final StoreInteractor _storeInteractor;
  final GoogleService _googleService;

  FirebaseAuthRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _storeInteractor = GetIt.I<StoreInteractor>(),
        _googleService = GetIt.I<GoogleService>();

  @override
  Future<bool> get isLoggedIn async {
    final currentUser = _firebaseAuth.currentUser;
    final token = await _storeInteractor.getToken();
    return currentUser != null && token != null;
  }

  //TODO: only for test - required to remove
  @override
  Future<void> loginWithEmail() async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: 'asd@asd.asd',
        password: 'asdasd',
      );
      await _storeInteractor.setToken(authResult.user.uid);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      final googleAuthentication = await _googleService.getGoogleAuthData();
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      await _storeInteractor.setToken(authResult.user.uid);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  @override
  Future<void> loginWithApple() {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<bool> logOut() async {
    await _firebaseAuth.signOut();
    await _googleService.signOut();
    return await _storeInteractor.removeToken();
  }
}