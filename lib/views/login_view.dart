import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notetaker/constants/routes.dart';
import 'package:notetaker/services/auth/auth_exceptions.dart';
import 'package:notetaker/services/auth/auth_service.dart';
import 'package:notetaker/utilities/dailogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

// inits function. create controllers
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  // dispose function, dispose controllers
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // register user function
  _loginUser() async {
    final email = _email.text;
    final password = _password.text;

    try {
      await AuthService.firebase().logIn(email: email, password: password);
      final user = AuthService.firebase().currentUser;
      if (user?.isEmailVerified ?? false) {
        //users email is verified
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          notesRoute,
          (route) => false,
        );
      } else {
        if (!mounted) return;
        //users email is not verified
        Navigator.of(context).pushNamedAndRemoveUntil(
          verifyEmailRoute,
          (route) => false,
        );
      }
    } on UserNotFoundAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'User not found');
      devtools.log('User not found!');
    } on WrongPasswordAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Wrong password');
    } on GenericAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Authentication Error');
    }
  }

  _goToRegisterView() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(registerRoute, (route) => false);
  }

  // MAIN VIEW WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'johndoe@gmail.com'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(hintText: '********'),
          ),
          TextButton(
            onPressed: _loginUser,
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: _goToRegisterView,
              child: const Text('Not registered Yet? Register here!'))
        ],
      ),
    );
  }
}
