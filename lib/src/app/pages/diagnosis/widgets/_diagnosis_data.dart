part of '../diagnosis_page.dart';

class _DiagnosisData extends StatelessWidget {
  final averageBloodSugar = getAverageBloodSugarStatistic();

  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    return Column(
      children: [
        Text('Min: ${getMinBloodSugarValue()}, Max: ${getMaxBloodSugarValue()}'),
        SizedBox(height: 50.0),
        Expanded(
          child: Column(
            children: [
              Text(
                'Your blood indicator for last 7 days: ${averageBloodSugar.bloodSugar.toStringAsFixed(1)} mmol/L.\n Your diagnosis: ${averageBloodSugar.getDiagnosis(locale)}', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              _buildRecommendationText(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationText() {
    switch (averageBloodSugar.diagnosis) {
      case BloodSugarDiagnosis.hypoglycemia:
      case BloodSugarDiagnosis.hyperglycemia:
        return Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Text(
            'Normal: 4.1 < value < 5.9.\nPlease, consalt your doctor',
            textAlign: TextAlign.center,
          ),
        );
      case BloodSugarDiagnosis.normal:
      default:
        return SizedBox();
    }
  }
}
