import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      final userCredentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredentials);
    } on FirebaseAuthException catch (e) {
      print('this is the error $e.code');
      if (e.code == 'invalid-credential') {
        print('User not found!');
      } else if (e.code == 'Wrong password') {
        print('Wrong password');
      }
    } catch (e) {
      print(e);
    }
  }

  _goToRegisterView() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/register/', (route) => false);
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