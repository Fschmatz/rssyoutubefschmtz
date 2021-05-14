import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/db/channelDao.dart';
import 'package:rssyoutubefschmtz/pages/saveEditChannel.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/builderFeedList.dart';

class ChannelList extends StatefulWidget {
  const ChannelList({Key key}) : super(key: key);

  @override
  _ChannelListState createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {

  final dbChannel = ChannelDao.instance;
  List<Map<String, dynamic>> channelList = [];

  @override
  void initState() {
    getAllChannels();
    super.initState();
  }

  void deleteChannel(int id) async {
    final delete = await dbChannel.delete(id);
  }

  Future<void> getAllChannels() async {
    var resp = await dbChannel.queryAllRows();
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
                        builder: (BuildContext context) =>  BuilderFeedList(
                          key: UniqueKey(),
                          feedUrl: channelList[index]['channelLink'],
                          channelName: channelList[index]['channelName'],
                          index: 0,
                        ),
                        fullscreenDialog: true,
                      ));
                  },
               // leading: Icon(Icons.video_collection_outlined),
                title: Text(channelList[index]['channelName'],style: TextStyle(fontSize: 16),),
                trailing: Wrap(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete_outline,size: 20,),
                      splashRadius: 25,
                      onPressed: () {
                        deleteChannel(channelList[index]['idChannel']);
                        getAllChannels();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => SaveEditChannel(
                                channelId: channelList[index]['idChannel'],
                                channelLink: channelList[index]['channelLink'],
                                channelName: channelList[index]['channelName'],
                                edit: true,
                              ),
                              fullscreenDialog: true,
                            ))
                            .then((value) =>
                            getAllChannels());
                      },
                      icon: Icon(Icons.edit_outlined,size: 20,),
                      splashRadius: 25,
                    ),
                  ],
                ),

              );
            }),
      ]),
    );
  }
}
