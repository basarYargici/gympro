import 'package:flutter/material.dart';
import 'package:gym_pro/pages/after_login/web_view_page.dart';

import '../../firebase_helper.dart';
import '../../models/notify_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  late final PageController _pageController;
  int currentIndex = 0;

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
          children: [
            StreamBuilder(
              stream: FirebaseHelper().getNotified(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: getErrorOccuredCard());
                }
                if (snapshot.hasData) {
                  if (snapshot.data?.news != null &&
                      snapshot.data?.campaigns != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "News",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        getNewsSlider(snapshot.data?.news),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 16,
                            left: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          child: Text(
                            "Campaigns",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        getCampaignSlider(snapshot.data?.campaigns)
                      ],
                    );
                  }
                  return Center(child: getErrorOccuredCard());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Card getErrorOccuredCard() {
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

  CarouselSlider getNewsSlider(List<NotifyItemModel>? newsItemModel) {
    return CarouselSlider(
      options: CarouselOptions(height: 300),
      items: newsItemModel?.map((news) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () => navigateToWebViewWidget(
                context,
                "https://www.njoy.com.tr",
              ),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title.toString(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        Text(
                          news.description.toString(),
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              news.imageUrl.toString(),
                              fit: BoxFit.fitHeight,
                            )),
                      ],
                    ),
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  CarouselSlider getCampaignSlider(List<NotifyItemModel>? newsItemModel) {
    return CarouselSlider(
      options: CarouselOptions(height: 300),
      items: newsItemModel?.map((campaign) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () => navigateToWebViewWidget(
                context,
                "https://www.njoy.com.tr",
              ),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title.toString(),
                        textAlign: TextAlign.start,
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
                      SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            campaign.imageUrl.toString(),
                            fit: BoxFit.fitWidth,
                            height: 200,
                          )),
                    ],
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  void navigateToWebViewWidget(BuildContext context, String webUrl) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => WebViewPage(
          url: webUrl,
        ),
      ),
    );
  }
}
