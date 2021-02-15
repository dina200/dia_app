part of '../user_tab.dart';

class _UserDataForm extends StatefulWidget {
  @override
  _UserDataFormState createState() => _UserDataFormState();
}

class _UserDataFormState extends State<_UserDataForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameKey = GlobalKey<FormFieldState<String>>();
  final _docEmailKey = GlobalKey<FormFieldState<String>>();

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
                    initialValue: 'asd',
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
                    initialValue: 'asd@asd.asd',
                    textAlign: TextAlign.center,
                    validator: _emailValidator,
                    decoration: InputDecoration(hintText: _locale.docEmailExample),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          RaisedButton(
            child: Text(_locale.save),
            onPressed: () {
              //TODO: save data to backend
            },
          ),
          SizedBox(height: 32.0),
          RaisedButton(
            child: Text(_locale.exit),
            onPressed: () {
              //TODO: exit
            },
          ),
        ],
      ),
    );
  }

  String _emailValidator(String email) {
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

  String _userNameValidator(String userName) {
    if(userName?.isEmpty ?? false) {
      return _locale.errorInputData;
    }
    return null;
  }
}
