import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/pages/diagnosis/diagnosis_page.dart';
import 'package:dia_app/src/app/pages/main/main_page_presenter.dart';
import 'package:dia_app/src/app/widgets/loading_layout.dart';
import 'package:dia_app/src/app/widgets/padding_wrapper_for_tab.dart';
import 'package:dia_app/src/app/widgets/size_wrapper_for_text_form_field.dart';
import 'package:dia_app/src/domain/entities/statistic.dart';

part 'widgets/_blood_sugar_storage_form.dart';
part 'widgets/_diagnosis_button.dart';

class DiagnosticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _watch = context.watch<MainPagePresenter>();
    return LoadingLayout(
      isLoading: _watch.isSavingData,
      child: PaddingWrapperForTab(
        child: Column(
          children: [
            Expanded(
              child: Center(child: _BloodSugarStorageForm()),
            ),
            _DiagnosisButton(),
          ],
        ),
      ),
    );
  }
}
