import 'package:flutter/material.dart';
import 'package:no_name/services/authentication.dart';
import 'package:no_name/services/database.dart';
import 'package:no_name/services/shared_pref.dart';
import 'package:no_name/shared/common_snackbar.dart';
import 'package:no_name/shared/cuper_loading.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _suFormKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  String _name = "";
  String _email = "";
  String _pass = "";
  bool _signingUpLoading = false;
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _suFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            focusNode: _nameFocus,
            onChanged: (val) => _name = val,
            decoration: const InputDecoration(
              label: Text("Name"),
            ),
            textInputAction: TextInputAction.next,
          ),
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
              if (_suFormKey.currentState!.validate()) {
                setState(() => _signingUpLoading = true);
                try {
                  dynamic result = await AuthenticationServices()
                      .registerWithMailPass(_name, _email, _pass);
                  if (result != null) {
                    UserSharedPref.setUserID(result);
                  } else {
                    commonSnackbar(STHWENTWRONG, context);
                  }
                } catch (e) {
                  commonSnackbar(STHWENTWRONG, context);
                }
                setState(() => _signingUpLoading = false);
              }
            },
            child: !_signingUpLoading
                ? const Text(
                    "Sign up",
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
