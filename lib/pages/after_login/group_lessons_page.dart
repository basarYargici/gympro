import 'package:flutter/material.dart';
import 'package:gym_pro/pages/after_login/web_view_page.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../../models/group_lesson_item_model.dart';

class GroupLessonPage extends StatefulWidget {
  const GroupLessonPage({super.key});

  @override
  State<GroupLessonPage> createState() => _GroupLessonPageState();
}

class _GroupLessonPageState extends State<GroupLessonPage> {
  late final List<GroupLessonItem> _listItem;
  final List<String> titles = [];
  final List<Widget> images = [];

  @override
  void initState() {
    _listItem = [
      createGroupLessonItem(
        "Pooling Lesson",
        "assets/images/pool.png",
        "https://www.njoy.com.tr/mecidiyekoy-yuzme-dersi/",
      ),
      createGroupLessonItem(
        "Bodybuilding Lesson",
        "assets/images/body_building.jpg",
        "https://www.njoy.com.tr/mecidiyekoy-vucut-gelistirme-salonu/",
      ),
      createGroupLessonItem(
        "Pilates Lesson",
        "assets/images/pilates.jpg",
        "https://www.njoy.com.tr/mecidiyekoy-pilates-salonu/",
      ),
      createGroupLessonItem(
        "Performer Pilates Lesson",
        "assets/images/performer_pilates.jpg",
        "https://www.njoy.com.tr/personal-training-nedir/",
      ),
      createGroupLessonItem(
        "Leg Day Lesson",
        "assets/images/leg_day.jpg",
        "https://www.njoy.com.tr/mecidiyekoy-spor-salonu/",
      ),
    ];

    images.addAll(
      _listItem.map((e) =>
          // todo add placeholder and on error
          Image.asset(e.imageUrl.toString())),
    );
    titles.addAll(
      _listItem.map((e) => e.text.toString()),
    );

    super.initState();
  }

  GroupLessonItem createGroupLessonItem(
    String text,
    String imageUrl,
    String webUrl,
  ) {
    return GroupLessonItem(
      text: text,
      imageUrl: imageUrl,
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => WebViewPage(url: webUrl),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButton(context),
      body: Column(children: [
        Expanded(
          child: VerticalCardPager(
            titles: titles,
            images: images,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            onPageChanged: (page) {},
            onSelectedItem: (index) {
              _listItem[index].onTap?.call();
            },
            initialPage: 0,
            align: ALIGN.CENTER,
          ),
        ),
      ]),
    );
  }

  AppBar backButton(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      title: const Text("Group Lessons For Today"),
    );
  }
}
