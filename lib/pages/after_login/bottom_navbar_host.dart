import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/pages/after_login/qr_page.dart';
import 'package:gym_pro/pages/after_login/notify_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'home_page.dart';

class BottomNavBarHost extends StatefulWidget {
  const BottomNavBarHost({super.key});

  @override
  State<BottomNavBarHost> createState() => _BottomNavBarHostState();
}

class _BottomNavBarHostState extends State<BottomNavBarHost> {
  PersistentTabController? controller;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu),
        title: const Text("Home"),
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
      ),
    );
  }
}
