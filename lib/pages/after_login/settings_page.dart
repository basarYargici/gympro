import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/campaigns_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  final List<CampaignItemModel> campaigns = [
    CampaignItemModel(
      title: "Dapibus Nulla",
      description:
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. ",
      imageUrl: "https://dummyimage.com/1200x1671.png/ff4444/ffffff",
    ),
    CampaignItemModel(
      title: "Metus",
      description:
          "Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.",
      imageUrl: "http://dummyimage.com/1200x1708.png/ff4444/ffffff",
    ),
    CampaignItemModel(
      title: "Mauris",
      description:
          "Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.",
      imageUrl: "http://dummyimage.com/162x100.png/ff4444/ffffff",
    ),
    CampaignItemModel(
      title: "Suscipit",
      description: "Proin risus. Praesent lectus. ",
      imageUrl: "http://dummyimage.com/1200x1708.png/ff4444/ffffff",
    ),
    CampaignItemModel(
      title: "Amazon",
      description: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
      imageUrl: "https://dummyimage.com/1200x1671.png/ff4444/ffffff",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20.0,
                left: 20.0,
                top: 80.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campaigns[currentIndex].title.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    campaigns[currentIndex].description.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DotsIndicator(
                  dotsCount: campaigns.length,
                  position: currentIndex.toDouble(),
                  decorator: const DotsDecorator(
                      activeColor: CupertinoColors.activeBlue),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    height: 50,
                    minWidth: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: CupertinoColors.activeBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.height,
              child: PageView.builder(
                itemCount: campaigns.length,
                onPageChanged: (int page) {
                  setState(() {
                    currentIndex = page;
                  });
                },
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    campaigns[currentIndex].imageUrl.toString(),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
