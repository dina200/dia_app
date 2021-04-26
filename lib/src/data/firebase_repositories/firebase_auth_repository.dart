import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:dia_app/src/device/utils/google_service.dart';
import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/repositories_contracts/auth_repository.dart';

import 'dia_firestore_helper.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleService _googleService;

  FirebaseAuthRepository()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleService = GetIt.I<GoogleService>();

  @override
  Future<bool> get isLoggedIn async {
    final currentUser = _firebaseAuth.currentUser;
    final token = await StoreInteractor.getToken();
    return currentUser != null && token != null;
  }

  @override
  Future<int> get role async {
    if (await isLoggedIn) {
      return await StoreInteractor.getRole();
    }
    return null;
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
      await _savePatientData(authResult.user);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }


  @override
  Future<void> loginWithGoogleAsDoctor() async {
    try {
      final googleAuthentication = await _googleService.getGoogleAuthData();
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      await _saveDoctorData(authResult.user);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  @override
  Future<bool> logOut() async {
    await _googleService.signOut();
    await StoreInteractor.removeRole();
    return await StoreInteractor.removeToken();
  }

  Future<void> _savePatientData(User user) async {
    await StoreInteractor.setToken(user.uid);
    await StoreInteractor.setRole(0);
    await DiaFirestoreHelper.savePatientData(
      await StoreInteractor.getToken(),
      user.displayName,
      user.email,
    );
  }

  Future<void> _saveDoctorData(User user) async {
    await StoreInteractor.setToken(user.uid);
    await StoreInteractor.setRole(1);
    await DiaFirestoreHelper.saveDoctorData(
      await StoreInteractor.getToken(),
      user.displayName,
      user.email,
    );
  }
}
