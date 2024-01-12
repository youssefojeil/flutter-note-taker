import 'package:flutter/material.dart';

import 'package:notetaker/constants/routes.dart';
import 'package:notetaker/services/auth/auth_exceptions.dart';
import 'package:notetaker/services/auth/auth_service.dart';
import 'package:notetaker/utilities/dailogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
  _registerUser() async {
    final email = _email.text;
    final password = _password.text;

    try {
      await AuthService.firebase().createUser(email: email, password: password);
      await AuthService.firebase().sendEmailVerification();
      if (!mounted) return;
      Navigator.of(context).pushNamed(verifyEmailRoute);
    } on WeakPasswordAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Weak Password');
    } on EmailAlreadyInUseAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Email Already in Use');
    } on InvalidEmailAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Invalid Email');
    } on GenericAuthException {
      if (!mounted) return;
      await showErrorDialog(context, 'Authentication Error');
    }
  }

  _goToLoginView() {
    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
  }

  // MAIN VIEW WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
            onPressed: _registerUser,
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: _goToLoginView,
            child: const Text('Already Registered, Please login'),
          )
        ],
      ),
    );
  }
}
