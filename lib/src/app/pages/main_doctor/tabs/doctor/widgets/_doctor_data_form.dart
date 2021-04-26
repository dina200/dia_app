part of '../doctor_tab.dart';

class _DoctorDataForm extends StatefulWidget {
  @override
  _DoctorDataFormState createState() => _DoctorDataFormState();
}

class _DoctorDataFormState extends State<_DoctorDataForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameKey = GlobalKey<FormFieldState<String>>();
  final _docEmailKey = GlobalKey<FormFieldState<String>>();

  MainDoctorPagePresenter get _watch => context.watch<MainDoctorPagePresenter>();
  MainDoctorPagePresenter get _read => context.read<MainDoctorPagePresenter>();
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
                    initialValue: _watch.doctor.fullName,
                    textAlign: TextAlign.center,
                    validator: _userNameValidator,
                    decoration: InputDecoration(hintText: _locale.userNameExample),
                    enabled: false,
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
                    initialValue: _watch.doctor.email,
                    textAlign: TextAlign.center,
                    validator: _docEmailValidator,
                    decoration: InputDecoration(hintText: _locale.docEmailExample),
                    enabled: false,
                  ),
                ),
              ),
            ],
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
}
