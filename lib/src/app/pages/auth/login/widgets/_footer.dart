part of '../login_page.dart';

class _Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<_Footer> {
  final _signUpRecognizer = TapGestureRecognizer();

  ThemeData get _theme => Theme.of(context);
  DiaLocalizations get _locale => DiaLocalizations.of(context);

  @override
  void initState() {
    super.initState();
    _signUpRecognizer.onTap = _onSignUpPressed;
  }

  void _onSignUpPressed() {
    Navigator.of(context).push(RegistrationPage.buildPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      alignment: Alignment.bottomCenter,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: _locale.dontHaveAccount,
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(text: ' '),
            TextSpan(
              style: TextStyle(color: _theme.accentColor),
              text: _locale.signUpVerb,
              recognizer: _signUpRecognizer,
            ),
          ],
        ),
      ),
    );
  }
}
