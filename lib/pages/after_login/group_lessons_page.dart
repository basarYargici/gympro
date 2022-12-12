import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../../models/group_lesson_item_model.dart';
import 'body_model_form_page.dart';

class GroupLessonPage extends StatefulWidget {
  const GroupLessonPage({super.key});

  @override
  State<GroupLessonPage> createState() => _GroupLessonPageState();
}

class _GroupLessonPageState extends State<GroupLessonPage> {
  late final List<GroupLessonItem> _listItem;

  final List<Widget> images1 = [
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://images.unsplash.com/photo-1541778480-fc1752bbc2a9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Njl8fHdhdGNofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://images.unsplash.com/photo-1434056886845-dac89ffe9b56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHdhdGNofGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8d2F0Y2h8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://images.unsplash.com/photo-1547996160-81dfa63595aa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHdhdGNofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://images.unsplash.com/photo-1617714651073-17a0fcd14f9e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDd8fHdhdGNofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://images.unsplash.com/photo-1618828272323-9f46e858e55e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTB8fHdhdGNofGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
        fit: BoxFit.cover,
      ),
    ),
  ];
  final List<String> titles1 = ['', '', '', '', '', ''];

  final List<String> titles = [];

  final List<Widget> images = [];
  @override
  void initState() {
    _listItem = [
      GroupLessonItem(
        text: "Upper Body Class",
        imageUrl:
            "https://images.radio-canada.ca/q_auto,w_1250/v1/ici-info/16x9/poids-halteres-salle-entrainement-centre-gym-generique.jpg",
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const BodyModelFormPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
      GroupLessonItem(
        text: "Running Class",
        imageUrl:
            "https://img.freepik.com/premium-photo/young-sports-woman-with-ponytail-working-out-gym-running-treadmill-side-view_109710-228.jpg",
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const BodyModelFormPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
      GroupLessonItem(
        text: "Yoga Class",
        imageUrl:
            "https://www.fitnessfirst.com.sg/-/media/project/evolution-wellness/fitness-first/south-east-asia/malaysia/classes/gentle-flow-yoga/gentle-flow-yoga_fb-sharing.png",
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const BodyModelFormPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
      GroupLessonItem(
        text: "Plates Class",
        imageUrl:
            "https://bestfitnessgyms.com/wp-content/uploads/2019/08/best-group-yoga-classes-in-gym-near-me.jpg",
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const BodyModelFormPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
      GroupLessonItem(
        text: "Leg Press Class",
        imageUrl:
            "https://cdn.mos.cms.futurecdn.net/m6x2Xq7QogyRVmY869oPom.jpg",
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => const BodyModelFormPage(),
              fullscreenDialog: true,
            ),
          );
        },
      ),
    ];

    images.addAll(
      _listItem.map((e) =>
          // todo add placeholder and on error
          Image.network(e.imageUrl.toString())),
    );
    titles.addAll(
      _listItem.map((e) => e.text.toString()),
    );

    super.initState();
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
            onSelectedItem: (index) {},
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
