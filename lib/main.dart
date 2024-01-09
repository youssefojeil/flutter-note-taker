import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
        ),
        home: const HomePage()),
  );
}

void _registerUser() async {}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: const Color.fromARGB(255, 120, 120, 158),
        elevation: 10.0,
        shadowColor: Colors.grey,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
          ),
          TextField(
            controller: _password,
          ),
          TextButton(
            onPressed: _registerUser,
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
