import 'package:dia_app/src/app/pages/statistics/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/pages/main_doctor/main_doctor_presenter.dart';

class PatientsTab extends StatefulWidget {
  @override
  _PatientsTabState createState() => _PatientsTabState();
}

class _PatientsTabState extends State<PatientsTab> {
  final _patientIdKey = GlobalKey<FormFieldState<String>>();
  
  ThemeData get _theme => Theme.of(context);
  DiaLocalizations get _locale => DiaLocalizations.of(context);
  MainDoctorPagePresenter get _watch => context.watch<MainDoctorPagePresenter>();
  MainDoctorPagePresenter get _read => context.read<MainDoctorPagePresenter>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
              RaisedButton(
                child: Text(_locale.addPatient),
                onPressed: () async {
                  try {
                    await _read.addPatient(_patientIdKey.currentState.value);
                    _showSnackBar(Text(_locale.dataSaved));
                  } catch (e) {
                    print(e);
                    _showSnackBar(
                      Text(
                        _locale.dataNotSaved,
                        style: TextStyle(color: _theme.errorColor),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(child: _buildPatientsList()),
      ],
    );
  }

  String _patientIdValidator(String userName) {
    if (userName?.isEmpty ?? false) {
      return _locale.errorInputData;
    }
    return null;
  }

  Widget _buildPatientsList() {
    if(_read.patients == null) {
      return Container();
    } else if (_read.patients.isEmpty) {
      return Center(child: Text(_locale.noData));
    } 
    final patients = _read.patients;
    return ListView.separated(
      itemCount: patients.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(patients[index].fullName),
          subtitle: Text('${patients[index].email}'),
          onTap: () {
            Navigator.of(context).push(StatisticsPage.buildPageRoute(patients[index].id));
          },
        );
      },
    );
  }

  void _showSnackBar(Text text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: text));
  }
}

