import 'package:flutter/material.dart';
import 'package:notetaker/constants/routes.dart';
import 'package:notetaker/services/auth/auth_service.dart';

_emailVerification() async {
  await AuthService.firebase().sendEmailVerification();
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
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify your account."),
          const Text(
              "If you haven't received a verification email yet, press the button below"),
          const TextButton(
              onPressed: _emailVerification,
              child: Text('Send email verification')),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logout();
                if (!mounted) return;

                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Back to Register')),
        ],
      ),
    );
  }
}
