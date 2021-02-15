import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'package:dia_app/src/app/widgets/padding_wrapper_for_tab.dart';
import 'package:dia_app/src/app/widgets/size_wrapper_for_text_form_field.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';

part 'widgets/_blood_sugar_storage_form.dart';

class DiagnosticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaddingWrapperForTab(
        child: _BloodSugarStorageForm(),
      ),
    );
  }
}
