import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final String image =
      "https://www.expatica.com/app/uploads/sites/10/2014/05/best-place-to-live-in-uk.jpg";
  late CountdownTimerController controller;
  int? endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime ?? 0, onEnd: onEnd);
  }

  @override
  void dispose() {
    controller.dispose();
    endTime = null;
    super.dispose();
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                top: 20.0,
              ),
              child: titleText(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                bottom: 24.0,
              ),
              child: descriptionText(),
            ),
            qrCard(context),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: refreshButton(),
              ),
            ),
            Center(
              child: CountdownTimer(
                controller: controller,
                onEnd: onEnd,
                endTime: endTime,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center refreshButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          onEnd();
          controller.disposeTimer();
        },
        child: const Text('Click to refresh The QR'),
      ),
    );
  }

  Text titleText() {
    return Text(
      "NJoy",
      style: TextStyle(
        fontSize: 25,
        color: Colors.grey.shade500,
      ),
    );
  }

  Text descriptionText() {
    return const Text(
      "Welcome To The GYM 🤸‍♂️",
      maxLines: 1,
      softWrap: false,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Center qrCard(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(0, 10, 246, 30),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Card(
          elevation: 0,
          child: qrCode(),
        ),
      ),
    );
  }

  QrImage qrCode() {
    return QrImage(
      data: "1234567890",
      version: QrVersions.auto,
      foregroundColor: Colors.black,
    );
  }
}
