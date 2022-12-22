import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/pages/before_login/signin_page.dart';
import 'package:gym_pro/shared_pref_helper.dart';
import 'package:lottie/lottie.dart';

import '../../models/onboard_model.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
        img: 'assets/get_news_lottie.json',
        text: "Get News From The NJoy",
        desc:
            "You can get news and campaigns from the club via the application"),
    OnboardModel(
        img: 'assets/qr_scan_lottie.json',
        text: "Scan The QR Code to Enter The Club ",
        desc: "You should scan the QR Code to enter the club in 3 seconds!"),
    OnboardModel(
        img: 'assets/record_progress_lottie.json',
        text: "Record Your Progress",
        desc: "Recording Your Progress Shows You How Far You Go!"),
  ];
  double currentDotPosition = 0.0;
  var sharedPrefHelper = SharedPrefHelper();
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: currentDotPosition != screens.length - 1
                ? IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_right,
                      size: 40,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    },
                  )
                : const SizedBox(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentDotPosition = value.toDouble();
                    });
                  },
                  itemCount: screens.length,
                  itemBuilder: (context, index) {
                    return getPageContent(index);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: getDotsIndicator(),
            )
          ],
        ),
      ),
    );
  }

  Column getPageContent(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 300,
          child: Lottie.asset(screens[index].img!),
        ),
        Text(
          screens[index].text!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 16),
        Text(
          screens[index].desc!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.0,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }

  Widget getDotsIndicator() {
    if (currentDotPosition == screens.length - 1) {
      return continueButton();
    }
    return DotsIndicator(
        dotsCount: screens.length, position: currentDotPosition);
  }

  Widget continueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
          onPressed: () {
            sharedPrefHelper.setOnboardingShown();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SigninPage()),
            );
          },
          height: 45,
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            "Continue",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
