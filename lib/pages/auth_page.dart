import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message.toString();
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message.toString();
      });
    }
  }

  Widget _title() {
    return const Text('Auth Page');
  }

  Widget _entryField(String hint, bool obscureText,
      TextEditingController textEditingController) {
    return TextField(
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
    );
  }

  Widget _errorMessage() {
    return Text((errorMessage == '') ? '' : "$errorMessage");
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: signInWithEmailAndPassword,
      child: const Text('Login'),
    );
  }

  Widget _signupButton() {
    return ElevatedButton(
      onPressed: createUserWithEmailAndPassword,
      child: const Text('Sign Up'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _entryField('Enter mail', false, _controllerEmail),
              _entryField('Enter password', true, _controllerPassword),
              _errorMessage(),
              _loginButton(),
              _signupButton()
            ]),
      ),
    );
  }
}
