import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:meta/meta.dart';

class User {
  final String id;
  final String fullName;

  User({
    @required this.id,
    @required this.fullName,
  })  : assert(id != null),
        assert(fullName != null);

  Future<List<BloodSugarStatistic>> getSugarInBloodStatistic() async {
    // TODO: add statistic from backend using user id
    return <BloodSugarStatistic>[];
  }
}
