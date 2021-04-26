part of '../doctor_tab.dart';

class _DoctorDataForm extends StatefulWidget {
  @override
  _DoctorDataFormState createState() => _DoctorDataFormState();
}

class _DoctorDataFormState extends State<_DoctorDataForm> {
  final _formKey = GlobalKey<FormState>();

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
              Expanded(child: Text(_locale.doctorName)),
              Expanded(
                flex: 2,
                child: SelectableText(_watch.doctor.fullName),
              ),
            ],
          ),
          SizedBox(height: 32.0),
          Row(
            children: <Widget>[
              Expanded(child: Text(_locale.docEmail)),
              Expanded(
                flex: 2,
                child: SelectableText(_watch.doctor.email),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
