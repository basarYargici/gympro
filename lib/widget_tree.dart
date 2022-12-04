import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_pro/pages/after_login/bottom_navbar_host.dart';
import 'package:gym_pro/pages/before_login/signin_page.dart';
import 'package:gym_pro/pages/before_login/onboard_page.dart';
import 'package:gym_pro/shared_pref_helper.dart';

import 'auth_helper.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  var sharedPrefHelper = SharedPrefHelper();
  late Future<bool> isOnboardingShown;
  late Stream<User?> isSignedin;

  @override
  void initState() {
    super.initState();
    isOnboardingShown = SharedPrefHelper().isOnboardingShown();
    isSignedin = AuthHelper().authStateChanges;
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
    return FutureBuilder(
        future: isOnboardingShown,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isShown = snapshot.data!;
            return setPageByOnboardingState(isShown);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget setPageByOnboardingState(bool isShown) {
    if (!isShown) {
      return const OnBoardPage();
    } else {
      return OnboardingShownWidget(isSignedin: isSignedin);
    }
  }
}

class OnboardingShownWidget extends StatelessWidget {
  const OnboardingShownWidget({
    Key? key,
    required this.isSignedin,
  }) : super(key: key);

  final Stream<User?> isSignedin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: isSignedin,
        builder: (context, snapshot) {
          // todo önce signin ekranı gelip gidiyor stream sonucu. connection state e göre bunu düzel
          if (snapshot.hasData) {
            return const BottomNavBarHost();
          } else {
            return const SigninPage();
          }
        },
      ),
    );
  }
}
