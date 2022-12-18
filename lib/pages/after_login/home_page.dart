import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_pro/pages/after_login/group_lessons_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:gym_pro/models/body_model.dart';
import 'package:gym_pro/models/user_model.dart';

import '../../firebase_helper.dart';
import '../../models/grid_item_model.dart';
import 'body_model_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseHelper firebaseHelper;
  late final List<GridItem> _listItem;
  var now = DateTime.now();
  var subscriptionLastDate = DateTime(2025); // todo get from firebase
  late Duration diff;
  late String diffText;
  late IconData icon;

  @override
  void initState() {
    diff = subscriptionLastDate.difference(now);
    var diffDays = int.parse(diff.inDays.toString());
    if (diffDays <= 0) {
      diff = const Duration();
      diffText = "Your Subscription Is Ended";
      icon = Icons.timer_off_outlined;
    } else {
      diffText =
          "Your Subscription Continues \n For ${diff.inDays.toString()} Days";
      icon = Icons.timer_outlined;
    }
    _listItem = [
      GridItem(
        backgroundColor: Colors.amberAccent,
        text: "New Body Info Record",
        icon: Icons.calculate,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const BodyModelFormPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
      GridItem(
        backgroundColor: Colors.blueAccent,
        text: "Group Lessons",
        icon: Icons.group,
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const GroupLessonPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    ];
    firebaseHelper = FirebaseHelper();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userGraph(firebaseHelper.currentUser!.uid),
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
              subscriptionInfoCard(context),
            ],
          ),
        ],
      ),
    );
  }

  // todo veri kayıt, graphta gösterimi
  FutureBuilder<MyUser> userGraph(String userId) {
    return FutureBuilder(
      future: FirebaseHelper().getUserBodyModel(userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'A Problem Occured While Loading The Data',
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data?.bodyModel == null ||
              snapshot.data?.bodyModel.isEmpty == true) {
            return Card(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'You Should Add Body Info Record To See The Graph',
                      softWrap: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            );
          }
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <LineSeries<BodyModel, String>>[
              LineSeries<BodyModel, String>(
                  dataSource: snapshot.data!.bodyModel,
                  xValueMapper: (BodyModel sales, _) => sales.weight,
                  yValueMapper: (BodyModel sales, _) =>
                      double.parse(sales.height.toString()))
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  GridView navigatorGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: _listItem
          .map(
            (item) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    item.onTap?.call();
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

  Padding subscriptionInfoCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          onTap: () {
            // item.onTap?.call();
          },
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 48,
                  ),
                  Expanded(
                    child: Text(
                      diffText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
