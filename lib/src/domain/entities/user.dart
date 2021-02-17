import 'package:meta/meta.dart';

import 'package:dia_app/src/domain/entities/statistic.dart';

class User {
  final String id;
  final String fullName;
  final String docsEmail;

  User({
    @required this.id,
    @required this.fullName,
    @required this.docsEmail,
  })  : assert(id != null),
        assert(fullName != null),
        assert(docsEmail != null);

  Future<List<BloodSugarStatistic>> getSugarInBloodStatistic() async {
    // TODO: add statistic from backend using user id
    return <BloodSugarStatistic>[];
  }
}
