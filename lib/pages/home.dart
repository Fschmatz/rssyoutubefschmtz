import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/pages/saved_channels_list.dart';
import 'package:rssyoutubefschmtz/pages/latest_videos_list.dart';
import 'package:rssyoutubefschmtz/pages/watch_later_list.dart';

import '../widgets/app_bar_sliver.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  ScrollController scrollController = ScrollController();
  final List<Widget> _tabs = [
    LatestVideosList(
      key: UniqueKey(),
    ),
    SavedChannelsList(
      key: UniqueKey(),
    ),
    WatchLaterList(key: UniqueKey())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[const AppBarSliver()];
          },
          body: MediaQuery.removePadding(removeTop: true, removeBottom: true,
              context: context, child: _tabs[_currentIndex]),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            scrollController.jumpTo(0);
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
