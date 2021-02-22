import 'package:meta/meta.dart';

class User {
  final String email;
  final String fullName;
  final String docsEmail;

  User({
    @required this.email,
    this.fullName,
    this.docsEmail,
  })  : assert(email != null);
}
