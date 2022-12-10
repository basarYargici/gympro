import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/pages/after_login/qr_page.dart';
import 'package:gym_pro/pages/after_login/notify_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../firebase_helper.dart';
import 'body_model_form_page.dart';
import 'home_page.dart';

class BottomNavBarHost extends StatefulWidget {
  const BottomNavBarHost({super.key});

  @override
  State<BottomNavBarHost> createState() => _BottomNavBarHostState();
}

class _BottomNavBarHostState extends State<BottomNavBarHost> {
  PersistentTabController? controller;
  late final User? user;

  bool _hideAppBar = false;
  String title = "Dashboard";

  @override
  void initState() {
    user = FirebaseHelper().currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [const HomePage(), const QrScreen(), const NotifyPage()];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.qrcode),
          title: ("QR Code"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.newspaper),
          title: ("News"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return Scaffold(
      appBar: appBar(),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        items: navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        hideNavigationBarWhenKeyboardShows: true,
        stateManagement: false,
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
        onItemSelected: (value) {
          if (value == 1) {
            _hideAppBar = true;
          } else {
            if (value == 0) {
              title = "Dashboard";
            }
            if (value == 2) {
              title = "News";
            }
            _hideAppBar = false;
          }
          setState(() {});
        },
      ),
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      color: Colors.orange,
      width: double.infinity,
      child: Column(children: [
        const SizedBox(
          height: 12,
        ),
        const CircleAvatar(
          radius: 52,
          backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?cs=srgb&dl=pexels-suliman-sallehi-1704488.jpg&fm=jpg'),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'ASDASD',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        Text(
          user?.email ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(
          height: 12,
        ),
      ]),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: Wrap(
        runSpacing: 8,
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("data"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BodyModelFormPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("data"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("data"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("data"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("data"),
            onTap: () {},
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("data"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? appBar() {
    if (_hideAppBar) {
      return null;
    }
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title),
    );
  }
}
