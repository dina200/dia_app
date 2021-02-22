part of '../login_page.dart';

class _LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO: only for test - required to remove
          RaisedButton(
            child: Text('SIGN IN WITH TEST ACCOUNT'),
            color: Colors.red,
            onPressed: () => _loginWithTestAccount(context),
          ),
          SizedBox(height: 16.0),
          RaisedButton(
            child: Text(locale.enterWithGoogle),
            onPressed: () => _loginWithGoogle(context),
          ),
          if (Platform.isIOS)
            Column(
              children: [
                SizedBox(height: 16.0),
                Text(locale.or),
                SizedBox(height: 16.0),
                RaisedButton(
                  child: Text(locale.enterWithApple),
                  onPressed: () => _loginWithApple(context),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _loginWithTestAccount(BuildContext context) async {
    await _login(context, context.read<LoginPagePresenter>().loginWithEmail);
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    await _login(context, context.read<LoginPagePresenter>().loginWithGoogle);
  }

  Future<void> _loginWithApple(BuildContext context) async {
    await _login(context, context.read<LoginPagePresenter>().loginWithApple);
  }

  Future<void> _login(BuildContext context, Function login) async {
    await login();
    await Navigator.of(context).pushAndRemoveUntil(
      MainPage.buildPageRoute(),
      (route) => false,
    );
  }
}
