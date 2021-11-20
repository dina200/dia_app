part of '../patients_tab.dart';

class _PatientAddingForm extends StatefulWidget {
  const _PatientAddingForm({Key key}) : super(key: key);

  @override
  _PatientAddingFormState createState() => _PatientAddingFormState();
}

class _PatientAddingFormState extends State<_PatientAddingForm> {
  final _patientIdKey = GlobalKey<FormFieldState<String>>();

  DiaLocalizations get _locale => DiaLocalizations.of(context);
  ThemeData get _theme => Theme.of(context);
  MainDoctorPagePresenter get _read => context.read<MainDoctorPagePresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: _theme.primaryColor.withOpacity(0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            key: _patientIdKey,
            textAlign: TextAlign.center,
            validator: _patientIdValidator,
            decoration: InputDecoration(hintText: _locale.enterPatientId),
          ),
          ElevatedButton(
            child: Text(_locale.addPatient),
            onPressed: _addPatient,
          ),
        ],
      ),
    );
  }

  String _patientIdValidator(String userName) {
    if (userName?.isEmpty ?? false) {
      return _locale.errorInputData;
    }
    return null;
  }

  void _addPatient() async {
    try {
      await _read.addPatient(_patientIdKey.currentState.value);
      _showSnackBar(Text(_locale.dataSaved));
      _patientIdKey.currentState.didChange('');
    } catch (e) {
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
