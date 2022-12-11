import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../../firebase_helper.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String? errorMessage;
  String? email;
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  late final FirebaseHelper firebaseHelper;

  @override
  void initState() {
    firebaseHelper = FirebaseHelper();
    super.initState();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
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

  void showToast(String? message) {
    Fluttertoast.showToast(
      msg: message ?? "Something went wrong",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                height: 200,
                child: Lottie.asset('assets/reset_password_lottie.json'),
              ),
              const Text(
                "We will send you an email to reset your e-mail",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              emailInput(),
              const SizedBox(height: 30),
              restartButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextField emailInput() {
    return TextField(
      controller: _controllerEmail,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: 'Email',
        hintText: 'Enter your E-mail',
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.black,
          size: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  MaterialButton restartButton() {
    return MaterialButton(
      onPressed: () {
        firebaseHelper.resetPassword(_controllerEmail.text).then((value) {
          if (value.isSuccess) {
            showToast("Password reset mail is sent to your email adress");
            Navigator.of(context).pop();
          } else {
            var message = "${value.message}. Please try again later";
            showToast(message);
          }
        });
      },
      height: 45,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 50,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Text(
        "Restart The Password",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}
