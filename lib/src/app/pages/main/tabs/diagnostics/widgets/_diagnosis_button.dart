part of '../diagnostics_tab.dart';

class _DiagnosisButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    return RaisedButton(
      child: Text(locale.showDiagnosis),
      onPressed: () => _onShowDiagnosisPressed(context),
    );
  }

  void _onShowDiagnosisPressed(BuildContext context) {
    Navigator.of(context).push(DiagnosisPage.buildPageRoute());
  }
}
