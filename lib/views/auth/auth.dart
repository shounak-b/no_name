import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_name/views/auth/sign_in.dart';
import 'package:no_name/views/auth/sign_up.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollBehavior _scrollBehavior = const ScrollBehavior(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch);

    final PageController _pageController = PageController();

    final List<Widget> _pages = <Widget>[
      const SignInPage(),
      const SignUpPage()
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: Consumer(builder: (context, ref, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: PageView(
              children: _pages,
              controller: _pageController,
              scrollBehavior: _scrollBehavior,
            ),
          ),
        );
      }),
    );
  }
}
