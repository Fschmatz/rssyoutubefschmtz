import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/pages/channel/channels_list.dart';
import 'package:rssyoutubefschmtz/pages/latest_videos_list.dart';
import 'package:rssyoutubefschmtz/pages/watch_later_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    LatestVideosList(
      key: UniqueKey(),
    ),
    ChannelsList(
      key: UniqueKey(),
    ),
    WatchLaterList(key: UniqueKey())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: _tabs[_currentIndex]),
        bottomNavigationBar: NavigationBar(
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
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.subscriptions_outlined),
              selectedIcon: Icon(
                Icons.subscriptions,
              ),
              label: 'Channels',
            ),
            NavigationDestination(
              icon: Icon(Icons.watch_later_outlined),
              selectedIcon: Icon(
                Icons.watch_later,
              ),
              label: 'Watch Later',
            ),
          ],
        ));
  }
}
