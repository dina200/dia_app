import 'package:meta/meta.dart';

class User {
  final String id;
  final String email;
  final String fullName;
  final String docsEmail;

  User({
    @required this.id,
    @required this.email,
    this.fullName,
    this.docsEmail,
  })  : assert(email != null);
}
