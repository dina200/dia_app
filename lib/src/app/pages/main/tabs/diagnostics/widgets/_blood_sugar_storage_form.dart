part of '../diagnostics_tab.dart';

class _BloodSugarStorageForm extends StatefulWidget {
  @override
  _BloodSugarStorageFormState createState() => _BloodSugarStorageFormState();
}

class _BloodSugarStorageFormState extends State<_BloodSugarStorageForm> {
  final _formKey = GlobalKey<FormState>();
  final _sugarInBloodKey = GlobalKey<FormFieldState<String>>();

  ThemeData get _theme => Theme.of(context);
  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _locale.enterSugarInBloodMeasure,
            style: _theme.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizeWrapperForTextFormField(
            child: TextFormField(
              key: _sugarInBloodKey,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              validator: _bloodSugarValidator,
              decoration: InputDecoration(
                hintText: _locale.bloodSugarDataExample,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          RaisedButton(
            child: Text(_locale.sendNewData),
            onPressed: _onSendNewDataPressed,
          ),
          SizedBox(height: 32.0),
          RaisedButton(
            child: Text(_locale.showDiagnosis),
            onPressed: _onShowDiagnosisPressed,
          ),
        ],
      ),
    );
  }

  String _bloodSugarValidator(value) {
    String pattern = r'^\d+(\.\d{1,2})?$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return _locale.errorInputData;
    } else if (!regExp.hasMatch(value)) {
      return _locale.errorExampleOfInput;
    } else if (regExp.hasMatch(value)) {
      double v = double.parse(value);
      if (v < 0.0 || v > 70.0) {
        return _locale.errorInvalidDataOfBloodSugar;
      }
    }
    return null;
  }

  void _onSendNewDataPressed() {
    //TODO: save data to backend
    if (_formKey.currentState.validate()) {
      final sugarBloodStatistic = SugarInBloodStatistic(
        timeMeasure: DateTime.now(),
        bloodSugar: double.tryParse(_sugarInBloodKey.currentState.value),
      );
      _showSnackBar(Text(sugarBloodStatistic.getFullData(_locale)));
    } else {
      _showSnackBar(
        Text(
          _locale.dataNotSaved,
          style: TextStyle(color: _theme.errorColor),
        ),
      );
    }
  }

  void _showSnackBar(Text text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: text));
  }

  void _onShowDiagnosisPressed() {
    //TODO: navigate to diagnosis page
  }
}
