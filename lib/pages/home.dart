import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/pages/channel_list.dart';
import 'package:rssyoutubefschmtz/pages/home/home_builder.dart';
import 'package:rssyoutubefschmtz/settings/settings_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final tabs = [
    HomeBuilder(
      key: UniqueKey(),
    ),
    ChannelList(
      key: UniqueKey(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('RSS YouTube'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context)
                      .textTheme
                      .headline6!
                      .color!
                      .withOpacity(0.8),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const SettingsPage(),
                        fullscreenDialog: true,
                      ));
                }),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: tabs,
        ),
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.black87,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.subscriptions_outlined),
              selectedIcon: Icon(
                Icons.subscriptions,
                color: Colors.black87,
              ),
              label: 'Channels',
            ),
          ],
        ));
  }
}
