import 'package:cloud_firestore/cloud_firestore.dart';

const String PATIENTS = 'patients';
const String DOCTORS = 'doctors';
const String ID = 'id';
const String NAME = 'name';
const String EMAIL = 'email';
const String DOC_EMAIL = 'docEmail';
const String BLOOD_SUGAR_STATISTIC = 'bloodSugarStatistic';
const String TIME_OF_MEASURE = 'timeOfMeasure';
const String BLOOD_SUGAR = 'bloodSugar';

class DiaFirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> savePatientData(
    String userId,
    String name,
    String email,
  ) async {
    final userDoc = _getPatientDocRef(userId);
    final userData = await userDoc.get();
    if (!userData.exists) {
      await userDoc.set({ID: userId, NAME: name, EMAIL: email});
    }
  }

  static Future<void> saveDoctorData(
    String userId,
    String name,
    String email,
  ) async {
    final userDoc = _getDoctorDocRef(userId);
    final userData = await userDoc.get();
    if (!userData.exists) {
      await userDoc.set({ID: userId, NAME: name, EMAIL: email});
    }
  }

  static Future<void> changePatientData(
    String userId,
    String name,
    String docEmail,
  ) async {
    await _getPatientDocRef(userId).update({NAME: name, DOC_EMAIL: docEmail});
  }

  static Future<Map<String, dynamic>> fetchPatientData(String userId) async {
    final snapshot = await _getPatientDocRef(userId).get();
    return snapshot.data();
  }

  static Future<Map<String, dynamic>> fetchDoctorData(String userId) async {
    final snapshot = await _getDoctorDocRef(userId).get();
    return snapshot.data();
  }

  static Future<List<QueryDocumentSnapshot>> fetchBloodSugarStatistic(
    String userId,
    DateTime from,
    DateTime to,
  ) async {
    final snapshot = await _getBloodSugarStatsCollectionRef(userId)
        .where(
          TIME_OF_MEASURE,
          isGreaterThan: Timestamp.fromDate(from),
          isLessThan: Timestamp.fromDate(to),
        )
        .orderBy(TIME_OF_MEASURE, descending: true)
        .get();
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

  static DocumentReference _getPatientDocRef(String userId) {
    return _firestore.collection(PATIENTS).doc(userId);
  }

  static DocumentReference _getDoctorDocRef(String userId) {
    return _firestore.collection(DOCTORS).doc(userId);
  }

  static CollectionReference _getBloodSugarStatsCollectionRef(String userId) {
    return _getPatientDocRef(userId).collection(BLOOD_SUGAR_STATISTIC);
  }
}
