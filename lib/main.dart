import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/pages/home_page.dart';
import 'package:gym_pro/widget_tree.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const WidgetTree(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [const HomePage(), const QrScreen(), const SettingsScreen()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.qrcode),
          title: ("Settings"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.settings),
          title: ("Settings"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.black, // Default is Colors.white.
      hideNavigationBarWhenKeyboardShows: true,
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
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('SettingsScreen')),
    );
  }
}

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: "1234567890",
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
