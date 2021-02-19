import 'package:cloud_firestore/cloud_firestore.dart';

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
    final userDoc = _getUserDocRef(userId);
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
    await _getUserDocRef(userId).set({NAME: name, DOC_EMAIL: docEmail});
  }

  static Future<Map<String, dynamic>> fetchUserData(String userId) async {
    final snapshot = await _getUserDocRef(userId).get();
    return snapshot.data();
  }

  static Future<List<QueryDocumentSnapshot>> fetchBloodSugarStatistic(
    String userId,
  ) async {
    final snapshot = await _getBloodSugarStatsCollectionRef(userId).get();
    return snapshot.docs;
  }

  static Future<void> setBloodSugarData(
    String userId,
    DateTime time,
    double bloodSugar,
  ) async {
    final statisticDoc = _getBloodSugarStatsCollectionRef(userId)
        .doc('${time.millisecondsSinceEpoch}');
    await statisticDoc.set({
      TIME_OF_MEASURE: Timestamp.fromDate(time),
      BLOOD_SUGAR: bloodSugar,
    });
  }

  static DocumentReference _getUserDocRef(String userId) {
    return _firestore.collection(USERS).doc(userId);
  }

  static CollectionReference _getBloodSugarStatsCollectionRef(String userId) {
    return _getUserDocRef(userId).collection(BLOOD_SUGAR_STATISTIC);
  }
}
