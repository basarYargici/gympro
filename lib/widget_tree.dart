import 'package:flutter/material.dart';
import 'package:gym_pro/pages/auth_page.dart';
import 'package:gym_pro/pages/home_page.dart';

import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        // TODO: store if user logged in once

        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
