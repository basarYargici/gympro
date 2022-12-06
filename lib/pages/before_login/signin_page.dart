import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../../firebase_helper.dart';
import '../../models/body_model.dart';
import '../../models/user_model.dart';
import '../after_login/home_page.dart';

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
  late final FirebaseHelper firebaseHelper;

  @override
  void initState() {
    firebaseHelper = FirebaseHelper();
    super.initState();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  Future<bool> signInWithEmailAndPassword() async {
    try {
      showCircularProgressIndicator();

      await firebaseHelper.signInWithEmailAndPassword(
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

      await firebaseHelper.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      await firebaseHelper.createUserDetailRecord(
        user: MyUser(
            id: firebaseHelper.currentUser!.uid, bodyModel: bodyModelList),
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
              const SizedBox(height: 50),
              Lottie.asset('assets/login_lottie.json'),
              const SizedBox(height: 40),
              emailInput(),
              const SizedBox(height: 20),
              passwordInput(),
              forgotPasswordButton(),
              const SizedBox(height: 30),
              signinButton(),
              const SizedBox(height: 30),
              registerRow(),
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

  TextField passwordInput() {
    return TextField(
      controller: _controllerPassword,
      cursorColor: Colors.black,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: 'Password',
        hintText: 'Enter Your Password',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: const Icon(
          Icons.password,
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

  // todo şu anlık dummy
  Row forgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  MaterialButton signinButton() {
    return MaterialButton(
      onPressed: () {
        signInWithEmailAndPassword().then((value) {
          if (value == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            showToast(errorMessage);
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
        "Login",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }

  /* 
  Widget _signupButton() {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.create,
        size: 32,
      ),
      onPressed: () {
        signUpUserWithEmailAndPassword().then((value) {
          if (value == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            showToast(errorMessage);
          }
        });
      },
      label: const Text('Sign Up'),
    );
  } ´
  */
  // todo sign up ekranı oluşturup buraya bağlayacağız. yukarıdaki _signupButton widget ı gibi kullanacağız
  Row registerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Register',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
