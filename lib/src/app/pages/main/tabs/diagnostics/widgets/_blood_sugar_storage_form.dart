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
  MainPagePresenter get _read => context.read<MainPagePresenter>();

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
          ElevatedButton(
            child: Text(_locale.sendNewData),
            onPressed: _onSendNewDataPressed,
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

  Future<void> _onSendNewDataPressed() async {
    if (_formKey.currentState.validate()) {
      final sugarBloodStatistic = BloodSugarStatistic(
        dateTimeOfMeasure: DateTime.now(),
        bloodSugar: double.tryParse(_sugarInBloodKey.currentState.value),
      );
      await _read.saveBloodSugarData(_sugarInBloodKey.currentState.value);
      _showSnackBar(
        Text(
          '${_locale.dataSaved}: ${sugarBloodStatistic.getFullData(_locale)}',
        ),
      );
      _sugarInBloodKey.currentState.didChange('');
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
  }
}
