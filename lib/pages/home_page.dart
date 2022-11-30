import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth_helper.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = AuthHelper().currentUser;

  Future<void> signOut() async {
    await AuthHelper().signOut();
  }

  Widget _title() {
    return const Text('Home Page');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
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
            children: [_userUid(), _signOutButton()],
          ),
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}
