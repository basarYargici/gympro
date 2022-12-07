import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/campaigns_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "CAMPAIGNS1",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(height: 300),
              items: campaigns.map((campaign) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  campaign.title.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                                Text(
                                  campaign.description.toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            // Todo imagesize is not dynamic
                            SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  campaign.imageUrl.toString(),
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ));
                  },
                );
              }).toList(),
            ),
            getCampaignPager(context),
          ],
        ),
      ),
    );
  }

  Padding getCampaignPager(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 32, right: 8, bottom: 8),
      child: Column(
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
      ),
    );
  }
}
