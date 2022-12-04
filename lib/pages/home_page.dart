import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_pro/pages/signin_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../auth_helper.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = AuthHelper().currentUser;
  String? errorMessage;

  Future<bool> signOut() async {
    try {
      showCircularProgressIndicator();
      await AuthHelper().signOut();

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

  Widget _title() {
    return const Text('Home Page');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: () {
        signOut().then(
          (value) {
            if (value == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SigninPage()),
              );
            } else {
              showToast(errorMessage);
            }
          },
        );
      },
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
          children: [
            SfCartesianChart(
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    // Bind data source
                    dataSource: <SalesData>[
                      SalesData('Jan', 35),
                      SalesData('Feb', 28),
                      SalesData('Mar', 34),
                      SalesData('Apr', 32),
                      SalesData('May', 40)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales)
              ],
            ),
            _userUid(),
            _signOutButton()
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNavBar()
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SizedBox(),
        bottomNavigationBar: BottomNavBar());
  }
}
