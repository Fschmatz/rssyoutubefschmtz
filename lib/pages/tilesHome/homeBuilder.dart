import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/db/channelDao.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/homeFeedList.dart';
import 'package:webfeed/webfeed.dart';

class HomeBuilder extends StatefulWidget {
  @override
  _HomeBuilderState createState() => _HomeBuilderState();

  HomeBuilder({Key key}) : super(key: key);
}

class _HomeBuilderState extends State<HomeBuilder> {

  Map<int, AtomItem> feedYoutube = new Map();
  String currentFeed;
  final dbChannel = ChannelDao.instance;
  List<Map<String, dynamic>> channelList = [];
  String urlYoutube = 'https://www.youtube.com/feeds/videos.xml?channel_id=';

  @override
  void initState() {
    getAllChannels();
    super.initState();
  }

  Future<void> getAllChannels() async {
    var resp = await dbChannel.queryAllOrderByChannelName();
    setState(() {
      channelList = resp;
    });
  }

  Future<void> getRssYoutubeData(int id) async {
    currentFeed =  urlYoutube + channelList[id]['channelLinkId'];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getAllChannels(),
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: channelList.length,
            itemBuilder: (context, index) {
              getRssYoutubeData(index);
              return HomeFeedList(
                key: UniqueKey(),
                feedUrl: currentFeed,
                index: index,
              );
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );

  }
}
