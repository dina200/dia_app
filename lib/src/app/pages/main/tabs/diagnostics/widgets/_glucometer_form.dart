part of '../diagnostics_tab.dart';

class _GlucometerForm extends StatefulWidget {
  @override
  _GlucometerFormState createState() => _GlucometerFormState();
}

class _GlucometerFormState extends State<_GlucometerForm> {
  bool _isGlucometerConnected = false;

  ThemeData get _theme => Theme.of(context);

  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  Widget build(BuildContext context) {
    if (!_isGlucometerConnected) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _locale.connectGlucometer,
            style: _theme.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          RaisedButton(
            child: Text(_locale.searchGlucometer),
            onPressed: () {
              setState(() => _isGlucometerConnected = true);
            },
          ),
        ],
      );
    } else {
      return Center(
        child: Text(
          _locale.fetchBloodSugar,
          style: _theme.textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
