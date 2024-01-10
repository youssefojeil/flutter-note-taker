import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notetaker/firebase_options.dart';
import 'package:notetaker/views/login_view.dart';
import 'package:notetaker/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/login/': (context) => const LoginView(),
          '/register/': (context) => const RegisterView()
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
        ),
        home: const HomePage()),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // final emailVerified = user?.emailVerified ?? false;
            // if (emailVerified) {
            //   print('Verified user');
            //   return const Text('Done');
            // } else {
            //   print('Please verify email');
            //   return const VerifyEmailView();
            // }
            return const LoginView();
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
