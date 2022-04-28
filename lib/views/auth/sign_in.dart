import 'package:flutter/material.dart';
import 'package:no_name/services/authentication.dart';
import 'package:no_name/services/database.dart';
import 'package:no_name/services/shared_pref.dart';
import 'package:no_name/shared/common_snackbar.dart';
import 'package:no_name/shared/cuper_loading.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _siFormKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  String _email = "";
  String _pass = "";
  bool _signingInLoading = false;
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _siFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            focusNode: _emailFocus,
            onChanged: (val) => _email = val,
            decoration: const InputDecoration(
              label: Text("Email"),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10.0, width: 0.0),
          TextFormField(
            focusNode: _passFocus,
            onChanged: (val) => _pass = val,
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
            obscureText: _hidePass,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 20.0, width: 0.0),
          TextButton(
            onPressed: () async {
              if (_siFormKey.currentState!.validate()) {
                setState(() => _signingInLoading = true);
                try {
                  dynamic result = await AuthenticationServices()
                      .signInWithMailPass(_email, _pass);
                  if (result != null) {
                    UserSharedPref.setUserID(result);
                  } else {
                    commonSnackbar(STHWENTWRONG, context);
                  }
                } catch (e) {
                  commonSnackbar(STHWENTWRONG, context);
                }
                setState(() => _signingInLoading = true);
              }
            },
            child: !_signingInLoading
                ? const Text(
                    "Sign in",
                    style: TextStyle(fontSize: 16.0),
                  )
                : const Loading(white: true),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
