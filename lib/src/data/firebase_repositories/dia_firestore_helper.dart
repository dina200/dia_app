import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dia_app/src/domain/entities/statistic.dart';

const String USERS = 'users';
const String NAME = 'name';
const String EMAIL = 'email';
const String DOC_EMAIL = 'docEmail';
const String BLOOD_SUGAR_STATISTIC = 'bloodSugarStatistic';
const String TIME_OF_MEASURE = 'timeOfMeasure';
const String BLOOD_SUGAR = 'bloodSugar';

class DiaFirestoreHelper {
  final FirebaseFirestore _firestore;

  DiaFirestoreHelper() : _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(String userId, String name, String email) async {
    final userDoc = _getUserDoc(userId);
    final userData = await userDoc.get();
    if (!userData.exists) {
      try {
        await userDoc.set({NAME: name, EMAIL: email});
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> changeUserData(
    String userId,
    String name,
    String docEmail,
  ) async {
    try {
      await _getUserDoc(userId).set({NAME: name, DOC_EMAIL: docEmail});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setBloodSugarData(
    String userId,
    BloodSugarStatistic data,
  ) async {
    try {
      final statisticDoc = _getBloodSugarStatsCollection(userId)
          .doc('${data.dateTimeOfMeasure.millisecondsSinceEpoch}');
      await statisticDoc.set({
        TIME_OF_MEASURE: Timestamp.fromDate(data.dateTimeOfMeasure),
        BLOOD_SUGAR: data.bloodSugar,
      });
    } catch (e) {
      rethrow;
    }
  }

  DocumentReference _getUserDoc(String userId) {
    return _firestore.collection(USERS).doc(userId);
  }

  CollectionReference _getBloodSugarStatsCollection(String userId) {
    return _getUserDoc(userId).collection(BLOOD_SUGAR_STATISTIC);
  }
}
