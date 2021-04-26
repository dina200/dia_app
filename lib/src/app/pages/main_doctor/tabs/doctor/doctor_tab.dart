import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/widgets/padding_wrapper_for_tab.dart';
import 'package:dia_app/src/app/widgets/size_wrapper_for_text_form_field.dart';
import 'package:dia_app/src/app/pages/main_doctor/main_doctor_presenter.dart';
import 'package:dia_app/src/app/widgets/loading_layout.dart';

part 'widgets/_doctor_data_form.dart';

class DoctorTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MainDoctorPagePresenter>();
    return LoadingLayout(
      isLoading: watch.isDoctorLoading,
      child: SingleChildScrollView(
        child: PaddingWrapperForTab(
          child: watch.isDoctorLoading ? SizedBox() : _DoctorDataForm(),
        ),
      ),
    );
  }
}
