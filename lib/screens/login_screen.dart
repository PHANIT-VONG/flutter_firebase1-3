import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_test/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Enter username',
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Enter password',
                ),
              ),
              const SizedBox(height: 30),
              CupertinoButton(
                color: Colors.blue,
                child: const Text('Login'),
                onPressed: () => login(
                  usernameController.text.trim(),
                  passwordController.text.trim(),
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future login(String username, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: username,
        password: password,
      )
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }
}
