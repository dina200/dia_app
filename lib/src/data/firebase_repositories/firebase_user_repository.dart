import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

import 'dia_firestore_helper.dart';

class FirebaseUserRepository extends UserRepository {
  Future<void> changeUserData(String name, String docEmail) async {
    try {
      await DiaFirestoreHelper.changeUserData(await _token, name, docEmail);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  Future<void> saveBloodSugarData(BloodSugarStatistic data) async {
    try {
      await DiaFirestoreHelper.setBloodSugarData(await _token, data);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  Future<String> get _token async => await StoreInteractor.getToken();
}
