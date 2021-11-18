import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';
import 'package:get_it/get_it.dart';

import 'dia_firestore_helper.dart';

class FirebaseUserRepositoryFactory extends UserRepositoryFactory {
  @override
  UserRepository createUserRepository(UserType type) {
    switch(type) {
      case UserType.Patient:
        return FirebasePatientRepository();
      case UserType.Doctor:
        return FirebaseDoctorRepository();
      default:
        throw AssertionError('This user type do not exist');
    }
  }
}

class FirebasePatientRepository extends _FirebaseUserRepository
    implements PatientRepository {
  @override
  Future<void> changePatientData(String name, String docEmail) async {
    await DiaFirestoreHelper.changePatientData(await _token, name, docEmail);
  }

  @override
  Future<Patient> fetchCurrentPatient() async {
    return await fetchPatientById(await _token);
  }

  @override
  Future<void> saveBloodSugarData(BloodSugarStatistic data) async {
    await DiaFirestoreHelper.setBloodSugarData(
      await _token,
      data.dateTimeOfMeasure,
      data.bloodSugar,
    );
  }

  @override
  Future<List<BloodSugarStatistic>> fetchBloodSugarStatistic([
    TimeRange timeRange,
  ]) async {
    return await fetchBloodSugarStatisticByPatientId(await _token, timeRange);
  }
}

class FirebaseDoctorRepository extends _FirebaseUserRepository
    implements DoctorRepository {
  @override
  Future<void> addPatient(String patientId) async {
    final data = await DiaFirestoreHelper.fetchPatientData(patientId);
    if (data == null) {
      throw AssertionError();
    }
    await DiaFirestoreHelper.addPatient(await _token, patientId);
  }

  @override
  Future<List<Patient>> fetchPatients() async {
    final doctor = await fetchDoctor();
    if (doctor.patientIds != null) {
      final mappedList = doctor.patientIds.map(
            (id) async {
          return await fetchPatientById(id);
        },
      );
      return await Future.wait(mappedList);
    }
    return [];
  }
}

abstract class _FirebaseUserRepository extends UserRepository {
  Future<String> get _token async {
    return await GetIt.I<StoreInteractor>().getToken();
  }

  @override
  Future<Doctor> fetchDoctor() async {
    final data = await DiaFirestoreHelper.fetchDoctorData(await _token);
    return Doctor(
      id: data[ID],
      email: data[EMAIL],
      fullName: data[NAME],
      patientIds: data[PATIENTS],
    );
  }

  @override
  Future<Patient> fetchPatientById(String patientId) async {
    final data = await DiaFirestoreHelper.fetchPatientData(patientId);
    return Patient(
      id: data[ID],
      email: data[EMAIL],
      fullName: data[NAME],
      docsEmail: data[DOC_EMAIL],
    );
  }

  @override
  Future<List<BloodSugarStatistic>> fetchBloodSugarStatisticByPatientId(
    String patientId, [
    TimeRange timeRange,
  ]) async {
    if (timeRange == null) {
      timeRange = TimeRange.getEntityByFilter(TimeRangeFilters.wholeTime);
    }
    final data = await DiaFirestoreHelper.fetchBloodSugarStatistic(
      patientId,
      timeRange.from,
      timeRange.to,
    );
    return await compute(_parseStatistic, data);
  }
}

FutureOr<List<BloodSugarStatistic>> _parseStatistic(
  List<QueryDocumentSnapshot> data,
) {
  return data.map((s) {
    return BloodSugarStatistic(
      bloodSugar: s[BLOOD_SUGAR],
      dateTimeOfMeasure: (s[TIME_OF_MEASURE] as Timestamp).toDate(),
    );
  }).toList();
}
