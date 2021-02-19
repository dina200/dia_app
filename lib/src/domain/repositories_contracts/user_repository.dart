import 'package:dia_app/src/domain/entities/statistic.dart';

abstract class UserRepository {
  Future<void> changeUserData(String name, String docEmail);

  Future<void> saveBloodSugarData(BloodSugarStatistic data);
}
