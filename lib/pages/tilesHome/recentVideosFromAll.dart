import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/channelFeed.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/classes/feedListChannels.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/builderFeedList.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/containerItemHome.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class RecentVideosFromAll extends StatefulWidget {
  @override
  _RecentVideosFromAllState createState() => _RecentVideosFromAllState();

  RecentVideosFromAll({Key key}) : super(key: key);
}

class _RecentVideosFromAllState extends State<RecentVideosFromAll> {
  bool carregando = true;
  Map<int, AtomItem> feedYoutube = new Map();
  List<ChannelFeed> listChannels = new FeedListChannels().getFeedListChannels();
  String currentFeed;

  @override
  void initState() {
    getRssYoutubeData(0);
    super.initState();
  }

  //Feed do Youtube sempre será de 15 items
  Future<void> getRssYoutubeData(int id) async {
      currentFeed = listChannels[id].linkFeed;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listChannels.length,
        itemBuilder: (context, index) {
          getRssYoutubeData(index);
          return BuilderFeedList(
            key: UniqueKey(),
            feedUrl: currentFeed,
            recents: true,
            index: index,
          );
        },
      ),
    );
  }
}
