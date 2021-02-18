part of '../login_page.dart';

class _LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = DiaLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RaisedButton(
            child: Text(locale.enterWithGoogle),
            onPressed: _loginWithGoogle,
          ),
          if (Platform.isIOS)
            Column(
              children: [
                SizedBox(height: 16.0),
                Text(locale.or),
                SizedBox(height: 16.0),
                RaisedButton(
                  child: Text(locale.enterWithApple),
                  onPressed: _loginWithApple,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _loginWithGoogle() async {
    //TODO: implement _loginWithGoogle
  }

  Future<void> _loginWithApple() async {
    //TODO: implement _loginWithApple
  }
}
