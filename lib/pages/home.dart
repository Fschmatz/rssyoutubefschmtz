import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rssyoutubefschmtz/pages/channelList.dart';
import 'package:rssyoutubefschmtz/pages/saveEditChannel.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/recentVideosFromAll.dart';
import 'package:rssyoutubefschmtz/settings/settingsPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final second = ChannelList();

  void refresh(){
    setState(() {});
  }

  int _currentIndex = 0;
  final tabs = [
    RecentVideosFromAll(),
    ChannelList(),
    SettingsPage(),
  ];

  List<Widget> pageList = [];

  @override
  Widget build(BuildContext context) {

    pageList.add(RecentVideosFromAll());
    pageList.add(ChannelList());
    pageList.add(SettingsPage());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('RSS YouTube'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: pageList,
        ),

      bottomNavigationBar: BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      elevation: 0.0,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection_outlined),
          label: 'Channels',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    ),

    );
  }
}
