part of '../user_tab.dart';

class _UserDataForm extends StatefulWidget {
  @override
  _UserDataFormState createState() => _UserDataFormState();
}

class _UserDataFormState extends State<_UserDataForm> {
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
          Row(
            children: <Widget>[
              Expanded(child: Text(_locale.userName)),
              Expanded(
                flex: 2,
                child: SizeWrapperForTextFormField(
                  child: TextFormField(
                    key: _userNameKey,
                    initialValue: _watch.user.fullName,
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
                    initialValue: _watch.user.docsEmail,
                    textAlign: TextAlign.center,
                    validator: _docEmailValidator,
                    decoration: InputDecoration(hintText: _locale.docEmailExample),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          RaisedButton(
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
