import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/pages/before_login/signin_page.dart';
import 'package:gym_pro/shared_pref_helper.dart';

import '../../models/onboard_model.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
        img: 'assets/images/jumpingGirl.png',
        text: "Commodo enim ipsum do magna enim ",
        desc:
            "Do ut tempor enim Lorem. Incididunt cillum cupidatat aute proident est eu incididunt ullamco sit nulla mollit labore officia eu."),
    OnboardModel(
        img: 'assets/images/jumpingGirl.png',
        text: "Commodo enim ipsum do magna enim ",
        desc:
            "Do ut tempor enim Lorem. Incididunt cillum cupidatat aute proident est eu incididunt ullamco sit nulla mollit labore officia eu."),
    OnboardModel(
        img: 'assets/images/jumpingGirl.png',
        text: "Commodo enim ipsum do magna enim ",
        desc:
            "Do ut tempor enim Lorem. Incididunt cillum cupidatat aute proident est eu incididunt ullamco sit nulla mollit labore officia eu."),
  ];
  double currentDotPosition = 0.0;
  var sharedPrefHelper = SharedPrefHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        centerTitle: true,
        title: const Text(
          "GymPRO",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              sharedPrefHelper.setOnboardingShown();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SigninPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentDotPosition = value.toDouble();
                    });
                  },
                  itemCount: screens.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          screens[index].img!,
                          fit: BoxFit.fill,
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
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: DotsIndicator(
                  dotsCount: screens.length, position: currentDotPosition),
            )
          ],
        ),
      ),
    );
  }
}
