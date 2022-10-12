import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';
import 'package:rssyoutubefschmtz/pages/save_edit_channel.dart';
import 'package:rssyoutubefschmtz/widgets/app_bar_sliver.dart';
import 'channel_video_list.dart';

class ChannelsList extends StatefulWidget {
  const ChannelsList({required Key key}) : super(key: key);

  @override
  _ChannelsListState createState() => _ChannelsListState();
}

class _ChannelsListState extends State<ChannelsList> {
  List<Map<String, dynamic>> channelList = [];
  String urlYoutube = 'https://www.youtube.com/feeds/videos.xml?channel_id=';
  String urlShareChannel = 'https://www.youtube.com/channel/';

  @override
  void initState() {
    super.initState();
    getAllChannels();
  }

  Future<void> getAllChannels() async {
    final dbChannel = ChannelDao.instance;
    var resp = await dbChannel.queryAllOrderByChannelName();
    setState(() {
      channelList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[const AppBarSliver()];
        },
        body:
            ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            child: (channelList.isEmpty)
                ? const SizedBox.shrink()
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    shrinkWrap: true,
                    itemCount: channelList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 10, 0),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChannelVideoList(
                                  key: UniqueKey(),
                                  feedUrl: urlYoutube +
                                      channelList[index]['channelLinkId'],
                                  channelName: channelList[index]
                                      ['channelName'],
                                  index: 0,
                                  channelId: channelList[index]['idChannel'],
                                  refreshList: getAllChannels,
                                  channelLink: channelList[index]
                                      ['channelLinkId'],
                                ),
                              ));
                        },
                        leading: const Icon(Icons.video_collection_outlined),
                        title: Text(
                          channelList[index]['channelName'],
                        ),
                      );
                    }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SaveEditChannel(
                  edit: false,
                  key: UniqueKey(),
                ),
              )).then((value) => getAllChannels());
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
