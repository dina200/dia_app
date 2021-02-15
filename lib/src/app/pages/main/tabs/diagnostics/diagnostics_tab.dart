import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

part 'widgets/_blood_sugar_storage_form.dart';

class DiagnosticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: _BloodSugarStorageForm(),
    );
  }
}
