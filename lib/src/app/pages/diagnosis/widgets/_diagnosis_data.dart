part of '../diagnosis_page.dart';

class _DiagnosisData extends StatelessWidget {
  final averageBloodSugar = getAverageBloodSugarStatistic();

  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    final min = getMinBloodSugarValue();
    final max = getMaxBloodSugarValue();
    final bloodSugar = averageBloodSugar.bloodSugar.toStringAsFixed(1);
    final diagnosis = averageBloodSugar.getDiagnosis(locale);

    return Column(
      children: [
        Text(locale.minMaxBloodSugar(min, max)),
        SizedBox(height: 50.0),
        Expanded(
          child: Column(
            children: [
              Text(
                locale.diagnosisData(bloodSugar, diagnosis),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              _buildRecommendationText(locale),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationText(DiaLocalizations locale) {
    switch (averageBloodSugar.diagnosis) {
      case BloodSugarDiagnosis.hypoglycemia:
      case BloodSugarDiagnosis.hyperglycemia:
        return Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Text(
            locale.referenceInfoAboutBloodSugar,
            textAlign: TextAlign.center,
          ),
        );
      case BloodSugarDiagnosis.normal:
      default:
        return SizedBox();
    }
  }
}
