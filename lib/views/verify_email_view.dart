import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

_emailVerification() async {
  final user = FirebaseAuth.instance.currentUser;
  await user?.sendEmailVerification();
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: const Column(
        children: [
          Text('Please verify email address'),
          TextButton(
              onPressed: _emailVerification,
              child: Text('Send email verification'))
        ],
      ),
    );
  }
}
