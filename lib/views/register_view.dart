import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

import 'package:notetaker/constants/routes.dart';

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
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      devtools.log(userCredentials.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        devtools.log('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        devtools.log('Email Already in Use');
      } else if (e.code == 'invalid-email') {
        devtools.log('Invalid Email');
      }
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
