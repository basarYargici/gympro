import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/pages/auth_page.dart';
import 'package:gym_pro/pages/home_page.dart';
import 'package:gym_pro/pages/onboard_page.dart';
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
  late Stream<User?> isSignedUp;

  @override
  void initState() {
    super.initState();
    isOnboardingShown = SharedPrefHelper().isOnboardingShown();
    isSignedUp = AuthHelper().authStateChanges;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isOnboardingShown,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final isShown = snapshot.data!;
              return setPageByOnboardingState(isShown);
            } else {
              return const CircularProgressIndicator();
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget setPageByOnboardingState(bool isShown) {
    if (!isShown) {
      return const OnBoardPage();
    } else {
      return OnboardingShownWidget(isSignedUp: isSignedUp);
    }
  }
}

class OnboardingShownWidget extends StatelessWidget {
  const OnboardingShownWidget({
    Key? key,
    required this.isSignedUp,
  }) : super(key: key);

  final Stream<User?> isSignedUp;
  // todo: kullanıcı kontrolü yanlış olsa da homepage e gidiyor test edilmeli. Şu anlık direkt home a gönderiyorum.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: isSignedUp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // final bool isLoggedIn = snapshot.hasData;
          // if (isLoggedIn) {
          return HomePage();
          // } else {
          // return const AuthPage();
          // }
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
