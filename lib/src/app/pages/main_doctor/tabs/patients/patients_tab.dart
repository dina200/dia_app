import 'package:dia_app/src/app/pages/statistics/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/dia_localizations.dart';
import 'package:provider/provider.dart';

import 'package:dia_app/src/app/pages/main_doctor/main_doctor_page_presenter.dart';

part 'widgets/_patient_adding_form.dart';

class PatientsTab extends StatefulWidget {
  @override
  _PatientsTabState createState() => _PatientsTabState();
}

class _PatientsTabState extends State<PatientsTab> {

  DiaLocalizations get _locale => DiaLocalizations.of(context);
  MainDoctorPagePresenter get _read => context.read<MainDoctorPagePresenter>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PatientAddingForm(),
        Expanded(child: _buildPatientsList()),
      ],
    );
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
            Navigator.of(context).push(
              StatisticsPage.buildPageRoute(patients[index].id),
            );
          },
        );
      },
    );
  }
}

