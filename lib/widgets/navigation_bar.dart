import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  static final NavBar _instance = NavBar._internal();

  late NavigationPage _page;

  NavigationPage get page => _page;

  set page(NavigationPage p) {
    if (_page == p) {
      return;
    }
    _page = p;
  }

  factory NavBar() {
    return _instance;
  }
  NavBar._internal() {
    _page = NavigationPage.home;
  }

  @override
  State<NavBar> createState() => _NavBar();
}

enum NavigationPage {
  home,
  log,
  setup,
  settings,
}

class _NavBar extends State<NavBar> {
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _selectedIndex = widget.page.index;
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      useLegacyColorScheme: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.add_alert),
          label: 'Log',
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.timer_rounded),
          label: 'Setup',
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).bottomAppBarTheme.surfaceTintColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/log');
        break;
      case 2:
        Navigator.pushNamed(context, '/setup');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }
}

extension NavigationPageExtension on NavigationPage {
  int get index {
    switch (this) {
      case NavigationPage.home:
        return 0;
      case NavigationPage.log:
        return 1;
      case NavigationPage.setup:
        return 3;
      case NavigationPage.settings:
        return 2;
      default:
        return -1;
    }
  }
}
