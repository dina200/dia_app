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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _locale.enterSugarInBloodMeasure,
              style: _theme.textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70.0,
              child: TextFormField(
                key: _sugarInBloodKey,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: _bloodSugarValidator,
                decoration: InputDecoration(
                  hintText: _locale.bloodSugarDataExample,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text(_locale.sendNewMeasure),
              onPressed: () {
                //TODO: save data to backend
                if (_formKey.currentState.validate()) {
                  final sugarBloodStatistic = SugarInBloodStatistic(
                    timeMeasure: DateTime.now(),
                    bloodSugar: double.tryParse(_sugarInBloodKey.currentState.value),
                  );
                  print(sugarBloodStatistic.getFullData(_locale));
                }
              },
            ),
            RaisedButton(
              child: Text(_locale.showDiagnosis),
              onPressed: () {
                //TODO: navigate to diagnosis page
              },
            ),
          ],
        ),
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
}
