import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final String image =
      "https://www.expatica.com/app/uploads/sites/10/2014/05/best-place-to-live-in-uk.jpg";
  bool isTimerFinished = false;
  int countDownTotal = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: SingleChildScrollView(
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
              circularCountdown()
            ],
          ),
        ),
      ),
    );
  }

  Widget circularCountdown() {
    if (isTimerFinished) {
      return Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: refreshButton(),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Center(
        child: TimeCircularCountdown(
          onCanceled: (unit, remaining) {
            isTimerFinished = true;
            countDownTotal = 3;
            setState(() {});
          },
          countdownTotalColor: Colors.orange,
          countdownRemainingColor: Colors.transparent,
          unit: CountdownUnit.second,
          countdownTotal: countDownTotal,
          textStyle: const TextStyle(
            color: Colors.orange,
            fontSize: 70,
          ),
          onFinished: () {
            isTimerFinished = true;
            setState(() {});
          },
        ),
      ),
    );
  }

  Center refreshButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          isTimerFinished = false;
          countDownTotal = 3;
          setState(() {});
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: const Color.fromARGB(0, 10, 246, 30),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Card(
                elevation: 0,
                child: (isTimerFinished) ? qrCodeError() : qrCode()),
          ),
        ],
      ),
    );
  }

  Widget qrCode() {
    return QrImage(
      data: "1234567890",
      version: QrVersions.auto,
      foregroundColor: Colors.black,
    );
  }

  Widget qrCodeError() {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Icon(
          Icons.error,
          color: Colors.black,
          size: 300,
        ),
        const Text(
          "Current Time Expired. \n You should scan the QR before the expiration time!",
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
