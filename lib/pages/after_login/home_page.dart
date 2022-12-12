import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_pro/pages/after_login/group_lessons_page.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
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
  late final StopWatchTimer _stopWatchTimer; // Create instance.

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      onChange: (value) {
        final displayTime = StopWatchTimer.getDisplayTime(value);
        print('displayTime $displayTime');
      },
      onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
      onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
      onEnded: () => print('timer ended'),
    );

    _stopWatchTimer.onStartTimer();

    _stopWatchTimer.setPresetHoursTime(1);

    _listItem = [
      GridItem(
        backgroundColor: Colors.amberAccent,
        text: "Yeni Boy Kilo Girişi",
        icon: Icons.calculate,
        onTap: () {
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
      GridItem(
        backgroundColor: Colors.amberAccent,
        text: "Yeni Boy Kilo Girişi",
        icon: Icons.calculate,
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const GroupLessonPage(),
              fullscreenDialog: true,
            ),
          );
        },
      )
    ];
    firebaseHelper = FirebaseHelper();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
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

              // todo timeri degistir. Altına Subscription için ekran ekle. O ekranda yeni üyelik fiyatları gösterilsin. Eğer kullanıcı herhangi birine tıklarsa pop up ile emin misiniz sorusuna evet derse, talebiniz klüp yönetimine iletilmiştir, işlemi klüp danışmanı ile sonlandırabilirsiniz yazdır.
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  print('Listen every minute. $value');
                  return Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  'minute',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Helvetica',
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  StopWatchTimer.getDisplayTime(value!)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Helvetica',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.amber),
                                child: Text(
                                    StopWatchTimer.getMinute(value).toString()),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.amber),
                                child: Text(StopWatchTimer.getRawSecond(value)
                                    .toString()),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),
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
}
