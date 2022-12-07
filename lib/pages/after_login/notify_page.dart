import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/campaigns_model.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  late final PageController _pageController;
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
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: getCampaignPager(context),
      ),
    );
  }

  Column getCampaignPager(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "CAMPAIGNS",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              campaigns[currentIndex].title.toString(),
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade900,
              ),
            ),
            Text(
              campaigns[currentIndex].description.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        // Todo imagesize is not dynamic
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
        Container(
          alignment: Alignment.center,
          child: DotsIndicator(
            dotsCount: campaigns.length,
            position: currentIndex.toDouble(),
            decorator:
                const DotsDecorator(activeColor: CupertinoColors.activeBlue),
          ),
        ),
      ],
    );
  }
}
