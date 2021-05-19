import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/db/channelDao.dart';
import 'package:rssyoutubefschmtz/pages/saveEditChannel.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/builderFeedList.dart';

class ChannelList extends StatefulWidget {
  ChannelList({Key key}) : super(key: key);

  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {

  List<Map<String, dynamic>> channelList = [];
  String urlYoutube = 'https://www.youtube.com/feeds/videos.xml?channel_id=';

  @override
  void initState() {
    getAllChannels();
    super.initState();
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
      body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            itemCount: channelList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => BuilderFeedList(
                          key: UniqueKey(),
                          feedUrl:
                          urlYoutube + channelList[index]['channelLinkId'],
                          channelName: channelList[index]['channelName'],
                          index: 0,
                          channelId: channelList[index]['idChannel'],
                          refreshList: getAllChannels,
                          channelLink: channelList[index]['channelLinkId'],
                        ),
                        fullscreenDialog: true,
                      ));
                },
                leading: Icon(Icons.video_collection_outlined),
                title: Text(
                  channelList[index]['channelName'],
                  style: TextStyle(fontSize: 16),
                ),
              );
            }),
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        elevation: 1,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SaveEditChannel(
                  edit: false,
                ),
                fullscreenDialog: true,
              )).then((value) => getAllChannels());
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

