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
  final dbChannel = ChannelDao.instance;
  List<Map<String, dynamic>> channelList = [];
  String urlYoutube = 'https://www.youtube.com/feeds/videos.xml?channel_id=';

  @override
  void initState() {
    getAllChannels();
    super.initState();
  }

  void deleteChannel(int id) async {
    final delete = await dbChannel.delete(id);
  }

  Future<void> getAllChannels() async {
    var resp = await dbChannel.queryAllOrderByChannelName();
    setState(() {
      channelList = resp;
    });
  }

  showAlertDialogOkDelete(BuildContext context, int index) {
    Widget okButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        deleteChannel(channelList[index]['idChannel']);
        getAllChannels();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Confirmation ", //
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "\nDelete Channel ?",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                        ),
                        fullscreenDialog: true,
                      ));
                },
                title: Text(
                  channelList[index]['channelName'],
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Wrap(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Theme.of(context).hintColor,
                      ),
                      splashRadius: 25,
                      onPressed: () {
                        showAlertDialogOkDelete(context, index);
                      },
                    ),
                    const SizedBox(width: 10,),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  SaveEditChannel(
                                    channelId: channelList[index]['idChannel'],
                                    channelLink: channelList[index]
                                    ['channelLinkId'],
                                    channelName: channelList[index]['channelName'],
                                    edit: true,
                                  ),
                              fullscreenDialog: true,
                            )).then((value) => getAllChannels());
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Theme.of(context).hintColor,
                      ),
                      splashRadius: 25,
                    ),
                  ],
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

