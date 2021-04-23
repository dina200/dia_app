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
  Future<void> changeUserData(String name, String docEmail) async {
    try {
      await DiaFirestoreHelper.changeUserData(await _token, name, docEmail);
    } catch (e) {
      //TODO: handle exception
      rethrow;
    }
  }

  Future<User> fetchUser() async {
    try {
      final data = await DiaFirestoreHelper.fetchUserData(await _token);
      return User(
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
    if (timeRange == null) {
      timeRange = TimeRange.getEntityByFilter(TimeRangeFilters.wholeTime);
    }
    try {
      final data = await DiaFirestoreHelper.fetchBloodSugarStatistic(
        await _token,
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
}

FutureOr<List<BloodSugarStatistic>> _parseStatistic(
  List<QueryDocumentSnapshot> data,
) {
  //TODO: remove old data
  return data.map((s) {
    return BloodSugarStatistic(
      bloodSugar: s[BLOOD_SUGAR],
      dateTimeOfMeasure: (s[TIME_OF_MEASURE] as Timestamp).toDate(),
    );
  }).toList();
}
