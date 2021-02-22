part of '../diagnosis_page.dart';

class _DiagnosisData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);
    final watch = context.watch<DiagnosisPagePresenter>();

    return Column(
      children: [
        Text(locale.minMaxBloodSugar(watch.min, watch.max)),
        SizedBox(height: 32.0),
        Text(
          locale.diagnosisData(watch.average),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        Text(
          locale.referenceInfoAboutBloodSugar,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}