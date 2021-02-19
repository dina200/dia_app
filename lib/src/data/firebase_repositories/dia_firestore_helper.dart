import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/user.dart';

const String USERS = 'users';
const String NAME = 'name';
const String EMAIL = 'email';
const String DOC_EMAIL = 'docEmail';
const String BLOOD_SUGAR_STATISTIC = 'bloodSugarStatistic';
const String TIME_OF_MEASURE = 'timeOfMeasure';
const String BLOOD_SUGAR = 'bloodSugar';

class DiaFirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> saveUserData(
    String userId,
    String name,
    String email,
  ) async {
    final userDoc = _getUserDoc(userId);
    final userData = await userDoc.get();
    if (!userData.exists) {
      await userDoc.set({NAME: name, EMAIL: email});
    }
  }

  static Future<void> changeUserData(
    String userId,
    String name,
    String docEmail,
  ) async {
    await _getUserDoc(userId).set({NAME: name, DOC_EMAIL: docEmail});
  }

  static Future<void> setBloodSugarData(
    String userId,
    BloodSugarStatistic data,
  ) async {
    final statisticDoc = _getBloodSugarStatsCollection(userId)
        .doc('${data.dateTimeOfMeasure.millisecondsSinceEpoch}');
    await statisticDoc.set({
      TIME_OF_MEASURE: Timestamp.fromDate(data.dateTimeOfMeasure),
      BLOOD_SUGAR: data.bloodSugar,
    });
  }

  static DocumentReference _getUserDoc(String userId) {
    return _firestore.collection(USERS).doc(userId);
  }

  static CollectionReference _getBloodSugarStatsCollection(String userId) {
    return _getUserDoc(userId).collection(BLOOD_SUGAR_STATISTIC);
  }
}
