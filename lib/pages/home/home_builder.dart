import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';
import 'package:rssyoutubefschmtz/pages/home/home_feed_list.dart';
import 'package:webfeed/webfeed.dart';

class HomeBuilder extends StatefulWidget {
  @override
  _HomeBuilderState createState() => _HomeBuilderState();

  const HomeBuilder({required Key key}) : super(key: key);
}

class _HomeBuilderState extends State<HomeBuilder> {
  Map<int, AtomItem> feedYoutube = {};
  late String currentFeed;
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
    if(mounted){
      setState(() {
        channelList = resp;
      });
    }
  }

  Future<void> getRssYoutubeData(int id) async {
    currentFeed = urlYoutube + channelList[id]['channelLinkId'];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getAllChannels(),
      child: channelList.isEmpty
          ? const SizedBox.shrink()
          : ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
