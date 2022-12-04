import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_pro/pages/home_page.dart';
import 'package:lottie/lottie.dart';

import '../auth_helper.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String? errorMessage;
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  Future<bool> signInWithEmailAndPassword() async {
    try {
      showCircularProgressIndicator();

      await AuthHelper().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message.toString();
      });
      return false;
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<bool> signUpUserWithEmailAndPassword() async {
    try {
      showCircularProgressIndicator();

      await AuthHelper().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message.toString();
      });
      return false;
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<dynamic> showCircularProgressIndicator() {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget _entryField(
    String hint,
    bool obscureText,
    bool showErrorMessage,
    TextEditingController textEditingController,
    Icon prefixIcon,
  ) {
    return TextField(
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          hintText: hint,
          prefixIcon: prefixIcon),
    );
  }

  Widget _signinButton() {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.lock_open,
        size: 32,
      ),
      onPressed: () {
        signInWithEmailAndPassword().then((value) {
          if (value == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            showToast(errorMessage.toString());
          }
        });
      },
      label: const Text('Sign in'),
    );
  }

  Widget _signupButton() {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.create,
        size: 32,
      ),
      onPressed: () {
        signUpUserWithEmailAndPassword().then((value) {
          if (value == true) {
            showToast("You have successfully signed up!");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            showToast(errorMessage.toString());
          }
        });
      },
      label: const Text('Sign Up'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/login_lottie.json'),
              const SizedBox(height: 40),
              _entryField(
                'Enter mail',
                false,
                false,
                _controllerEmail,
                const Icon(Icons.mail),
              ),
              const SizedBox(height: 4),
              _entryField(
                'Enter password',
                true,
                true,
                _controllerPassword,
                const Icon(Icons.password),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _signinButton()),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _signupButton(),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
