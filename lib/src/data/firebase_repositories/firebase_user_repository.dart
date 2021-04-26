import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:dia_app/src/device/utils/store_interactor.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';
import 'package:dia_app/src/domain/repositories_contracts/user_repository.dart';

import 'dia_firestore_helper.dart';

class FirebaseUserRepository extends UserRepository {
  @override
  Future<void> changePatientData(String name, String docEmail) async {
    try {
      await DiaFirestoreHelper.changePatientData(await _token, name, docEmail);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  @override
  Future<Patient> fetchPatient() async {
    return await fetchPatientById(await _token);
  }

  @override
  Future<Patient> fetchPatientById(String patientId) async {
    try {
      final data = await DiaFirestoreHelper.fetchPatientData(patientId);
      return Patient(
        id: data[ID],
        email: data[EMAIL],
        fullName: data[NAME],
        docsEmail: data[DOC_EMAIL],
      );
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  Future<void> saveBloodSugarData(BloodSugarStatistic data) async {
    try {
      await DiaFirestoreHelper.setBloodSugarData(
        await _token,
        data.dateTimeOfMeasure,
        data.bloodSugar,
      );
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  Future<List<BloodSugarStatistic>> fetchBloodSugarStatistic([
    TimeRange timeRange,
  ]) async {
    return await fetchBloodSugarStatisticByPatientId(await _token, timeRange);
  }
  Future<List<BloodSugarStatistic>> fetchBloodSugarStatisticByPatientId(String patientId, [
      TimeRange timeRange,
    ]) async {
      if (timeRange == null) {
        timeRange = TimeRange.getEntityByFilter(TimeRangeFilters.wholeTime);
      }
      try {
        final data = await DiaFirestoreHelper.fetchBloodSugarStatistic(
          patientId,
          timeRange.from,
          timeRange.to,
        );
        return await compute(_parseStatistic, data);
      } catch (e) {
        //TODO: handle exception
        rethrow;
      }
    }

  Future<String> get _token async => await StoreInteractor.getToken();

  @override
  Future<void> addPatient(String patientId) async {
    try {
      final data = await DiaFirestoreHelper.fetchPatientData(patientId);
      if(data == null) {
        throw AssertionError();
      }
      await DiaFirestoreHelper.addPatient(await _token, patientId);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  @override
  Future<Doctor> fetchDoctor() async {
    try {
      final data = await DiaFirestoreHelper.fetchDoctorData(await _token);
      return Doctor(
        id: data[ID],
        email: data[EMAIL],
        fullName: data[NAME],
        patientIds: data[PATIENTS],
      );
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }
  @override
  Future<List<Patient>> fetchPatients() async {
    try {
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
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
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
