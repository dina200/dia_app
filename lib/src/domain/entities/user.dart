import 'package:meta/meta.dart';

import 'package:dia_app/src/domain/entities/statistic.dart';

class User {
  final String email;
  final String fullName;
  final String docsEmail;

  User({
    @required this.email,
    this.fullName,
    this.docsEmail,
  })  : assert(email != null);

  Future<List<BloodSugarStatistic>> getSugarInBloodStatistic() async {
    // TODO: add statistic from backend using user id
    return <BloodSugarStatistic>[];
  }
}
