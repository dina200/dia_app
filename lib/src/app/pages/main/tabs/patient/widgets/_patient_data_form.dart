part of '../patient_tab.dart';

class _PatientDataForm extends StatefulWidget {
  @override
  _PatientDataFormState createState() => _PatientDataFormState();
}

class _PatientDataFormState extends State<_PatientDataForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameKey = GlobalKey<FormFieldState<String>>();
  final _docEmailKey = GlobalKey<FormFieldState<String>>();

  MainPagePresenter get _watch => context.watch<MainPagePresenter>();
  MainPagePresenter get _read => context.read<MainPagePresenter>();
  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: double.infinity,
            child: Column(
              children: [
                Text(_locale.actionWithUserId),
                SizedBox(height: 8.0),
                SelectableText(_watch.patient.id),
                SizedBox(height: 8.0),
                ElevatedButton(child: Text(_locale.sendId), onPressed: _read.sendUserId),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text(_locale.userName)),
              Expanded(
                flex: 2,
                child: SizeWrapperForTextFormField(
                  child: TextFormField(
                    key: _userNameKey,
                    initialValue: _watch.patient.fullName,
                    textAlign: TextAlign.center,
                    validator: _userNameValidator,
                    decoration: InputDecoration(hintText: _locale.userNameExample),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text(_locale.docEmail)),
              Expanded(
                flex: 2,
                child: SizeWrapperForTextFormField(
                  child: TextFormField(
                    key: _docEmailKey,
                    initialValue: _watch.patient.docEmail,
                    textAlign: TextAlign.center,
                    validator: _docEmailValidator,
                    decoration: InputDecoration(hintText: _locale.docEmailExample),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text(_locale.save),
            onPressed: _saveUserData,
          ),
        ],
      ),
    );
  }

  String _userNameValidator(String userName) {
    if(userName?.isEmpty ?? false) {
      return _locale.errorInputData;
    }
    return null;
  }

  String _docEmailValidator(String email) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if(email?.isEmpty ?? false) {
      return _locale.errorInputData;
    } else if (!regExp.hasMatch(email)) {
      return _locale.invalidEmailFormat;
    } else {
      return null;
    }
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState.validate()) {
      await _read.saveUserData(
        _userNameKey.currentState.value,
        _docEmailKey.currentState.value,
      );
    }
  }
}
