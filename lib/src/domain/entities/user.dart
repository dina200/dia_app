import 'package:meta/meta.dart';

enum UserRole {
  Patient,
  Doctor,
}

abstract class User {
  final String id;
  final String email;
  final String fullName;

  User({
    @required this.id,
    @required this.email,
    this.fullName,
  })  : assert(id != null), assert(email != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          fullName == other.fullName;

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ fullName.hashCode;
}

class Patient extends User {
  final String docsEmail;

  Patient({String id, String email, String fullName, this.docsEmail})
      : super (id: id, email: email, fullName: fullName);
}

class Doctor extends User {
  final List patientIds;

  Doctor({String id, String email, String fullName, this.patientIds})
      : super (id: id, email: email, fullName: fullName);
}