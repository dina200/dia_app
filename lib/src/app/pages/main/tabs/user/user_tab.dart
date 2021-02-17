import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';

import 'package:dia_app/src/app/widgets/padding_wrapper_for_tab.dart';
import 'package:dia_app/src/app/widgets/size_wrapper_for_text_form_field.dart';
import 'package:dia_app/src/data/mock_user.dart';
import 'package:dia_app/src/domain/entities/user.dart';

part 'widgets/_user_data_form.dart';

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaddingWrapperForTab(
        child: _UserDataForm(),
      ),
    );
  }
}
