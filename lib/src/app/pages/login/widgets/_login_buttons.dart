part of '../login_page.dart';

class _LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            child: Text(locale.enterWithGoogle),
            onPressed: () => _loginWithGoogle(context),
          ),
          SizedBox(height: 16.0),
          Text(locale.or),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text(locale.enterWithGoogleAsDoctor),
            onPressed: () => _loginWithGoogleAsDoctor(context),
          ),
        ],
      ),
    );
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    await _login(context, context.read<LoginPagePresenter>().loginWithGoogle);
  }

  Future<void> _loginWithGoogleAsDoctor(BuildContext context) async {
    await _loginAsDoctor(context, context.read<LoginPagePresenter>().loginWithGoogleAsDoctor);
  }

  Future<void> _login(BuildContext context, Function login) async {
    try {
      await login();
      await Navigator.of(context).pushAndRemoveUntil(
        MainPage.buildPageRoute(),
        (route) => false,
      );
    } on GoogleLoginException {}
  } 
  
  Future<void> _loginAsDoctor(BuildContext context, Function login) async {
    try {
      await login();
      await Navigator.of(context).pushAndRemoveUntil(
        MainDoctorPage.buildPageRoute(),
        (route) => false,
      );
    } on GoogleLoginException {}
  }
}
