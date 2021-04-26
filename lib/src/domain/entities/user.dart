import 'package:meta/meta.dart';

abstract class User {
  final String id;
  final String email;
  final String fullName;

  User({
    @required this.id,
    @required this.email,
    this.fullName,
  })  : assert(id != null), assert(email != null);
}

class Patient extends User {
  final String docsEmail;

  Patient({String id, String email, String fullName, this.docsEmail})
      : super (id: id, email: email, fullName: fullName);
}