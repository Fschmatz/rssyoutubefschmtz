import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rssreaderfschmtz/pages/tilesHome/listBuilder.dart';
import '../util/versaoNomeChangelog.dart';
import 'package:rssreaderfschmtz/configs/configs.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  //FEEDS URL
  String feedCursoEmVideo =
      'https://www.youtube.com/feeds/videos.xml?channel_id=UCrWvhVmt0Qac3HgsjQK62FQ';
  String feedNetNinja =
      'https://www.youtube.com/feeds/videos.xml?channel_id=UCW5YeuERMmlnqo4oq8vwUpg';
  String feedFreeCodeCamp =
      'https://www.youtube.com/feeds/videos.xml?channel_id=UC8butISFwT-Wl7EV0hUK0BQ';
  String feedMosh =
      'https://www.youtube.com/feeds/videos.xml?channel_id=UCWv7vMbMWH4-V0ZXdmDpPBA';
  String feedCodingTrain =
      'https://www.youtube.com/feeds/videos.xml?channel_id=UCvjgXvBlbQiydffZU7m1_aw';


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  floating: true,
                  snap: true,
                  pinned: true,
                  bottom: PreferredSize(
                    preferredSize: Size(0, kToolbarHeight),
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 9),
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 16.4),
                      controller: _tabController,
                      tabs: [
                        Tab(text: "Curso em Vídeo"),
                        Tab(text: "The Net Ninja"),
                        Tab(text: "FreeCodeCamp"),
                        Tab(text: "The Coding Train"),
                        Tab(text: "Mosh"),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                ListBuilder(feedUrl: feedCursoEmVideo),
                ListBuilder(feedUrl: feedNetNinja),
                ListBuilder(feedUrl: feedFreeCodeCamp),
                ListBuilder(feedUrl: feedCodingTrain),
                ListBuilder(feedUrl: feedMosh),
              ],
              // physics: NeverScrollableScrollPhysics(),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: AppBar(
                elevation: 0,
                title: Text("RSS Fschmtz " + versaoNomeChangelog.versaoApp),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => Configs(),
                                fullscreenDialog: true,
                              ));
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
