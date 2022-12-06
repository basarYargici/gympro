import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_pro/models/body_model.dart';
import 'package:gym_pro/models/user_model.dart';
import 'package:gym_pro/pages/before_login/signin_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../firebase_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User? user;
  late final FirebaseHelper firebaseHelper;
  String? errorMessage;

  @override
  void initState() {
    firebaseHelper = FirebaseHelper();
    user = FirebaseHelper().currentUser;
    super.initState();
  }

  Future<bool> signOut() async {
    try {
      showCircularProgressIndicator();
      await firebaseHelper.signOut();

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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            _userUid(),
            _signOutButton(),
            userGraph()
          ],
        ),
      ),
    );
  }

  // todo veri kayıt, graphta gösterimi ve eğer bodyModel boşsa ya da nullsa durumunu düzelt
  StreamBuilder<List<MyUser>> userGraph() {
    return StreamBuilder(
      stream: firebaseHelper.getUserDetail(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<BodyModel, String>>[
              LineSeries<BodyModel, String>(
                  dataSource: snapshot.data!.first.bodyModel!,
                  xValueMapper: (BodyModel sales, _) => sales.weight,
                  yValueMapper: (BodyModel sales, _) =>
                      double.parse(sales.height.toString()))
            ],
          );
        }
        return const Text("nanan");
      },
    );
  }
}
