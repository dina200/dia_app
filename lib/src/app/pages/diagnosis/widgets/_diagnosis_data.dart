part of '../diagnosis_page.dart';

class _DiagnosisData extends StatelessWidget {
  final averageBloodSugar = getAverageBloodSugarStatistic();

  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    final min = getMinBloodSugarValue();
    final max = getMaxBloodSugarValue();
    final bloodSugar = averageBloodSugar.bloodSugar.toStringAsFixed(2);

    return Column(
      children: [
        Text(locale.minMaxBloodSugar(min, max)),
        SizedBox(height: 32.0),
        Text(
          locale.diagnosisData(bloodSugar),
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