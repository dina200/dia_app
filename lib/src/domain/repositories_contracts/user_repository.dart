import 'package:dia_app/src/domain/entities/statistic.dart';
import 'package:dia_app/src/domain/entities/time_range.dart';
import 'package:dia_app/src/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> changeUserData(String name, String docEmail);

  Future<User> fetchUser();

  Future<void> saveBloodSugarData(BloodSugarStatistic data);

  Future<List<BloodSugarStatistic>> fetchBloodSugarStatistic([
    TimeRange timeRange,
  ]);
}
