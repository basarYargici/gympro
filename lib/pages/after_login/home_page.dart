import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_pro/pages/after_login/qr_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:gym_pro/models/body_model.dart';
import 'package:gym_pro/models/user_model.dart';
import 'package:gym_pro/pages/before_login/signin_page.dart';

import '../../firebase_helper.dart';
import '../../models/grid_item_model.dart';
import 'body_model_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final User? user;
  late final FirebaseHelper firebaseHelper;
  String? errorMessage;
  final List<GridItem> _listItem = [
    GridItem(
      backgroundColor: Colors.amberAccent,
      text: "Yeni Boy Kilo Girişi",
      icon: Icons.calculate,
    ),
    GridItem(
      backgroundColor: Colors.blueAccent,
      text: "GYM 2",
      icon: Icons.calculate,
    ),
    GridItem(
      backgroundColor: Colors.amberAccent,
      text: "Yeni Boy Kilo Girişi",
      icon: Icons.calculate,
    ),
    GridItem(
      backgroundColor: Colors.blueAccent,
      text: "GYM 2",
      icon: Icons.calculate,
    ),
  ];
  @override
  void initState() {
    firebaseHelper = FirebaseHelper();
    user = FirebaseHelper().currentUser;
    super.initState();
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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userGraph(),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Which feature?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              navigatorGrid(),
            ],
          ),
        ],
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
        return SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <LineSeries<BodyModel, String>>[
            LineSeries<BodyModel, String>(
                dataSource: List.empty(),
                xValueMapper: (BodyModel sales, _) => "0",
                yValueMapper: (BodyModel sales, _) => double.parse(""))
          ],
        );
      },
    );
  }

  GridView navigatorGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      shrinkWrap: true, // You won't see infinite size error
      children: _listItem
          .map(
            (item) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => const BodyModelFormPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: item.backgroundColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 32,
                        ),
                        Text(
                          item.text.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
