import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rssreaderfschmtz/classes/channelFeed.dart';
import 'package:rssreaderfschmtz/pages/tilesHome/listBuilder.dart';
import 'package:rssreaderfschmtz/configs/configs.dart';
import 'package:rssreaderfschmtz/util/versaoNomeChangelog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<ChannelFeed> listChannels = [];
  String currentFeed;

  @override
  void initState() {
    super.initState();
    listChannels.add(new ChannelFeed(
        name: 'Curso Em Vídeo',
        linkFeed:
            'https://www.youtube.com/feeds/videos.xml?channel_id=UCrWvhVmt0Qac3HgsjQK62FQ'));
    listChannels.add(new ChannelFeed(
        name: 'The Net Ninja',
        linkFeed:
            'https://www.youtube.com/feeds/videos.xml?channel_id=UCW5YeuERMmlnqo4oq8vwUpg'));
    listChannels.add(new ChannelFeed(
        name: 'FreeCodeCamp',
        linkFeed:
            'https://www.youtube.com/feeds/videos.xml?channel_id=UC8butISFwT-Wl7EV0hUK0BQ'));
    listChannels.add(new ChannelFeed(
        name: 'Fun With Flutter',
        linkFeed:
            'https://www.youtube.com/feeds/videos.xml?channel_id=UCU8Mj6LLoNBXqqeoOD64tFg'));
    listChannels.add(new ChannelFeed(
        name: 'The Coding Train',
        linkFeed:
            'https://www.youtube.com/feeds/videos.xml?channel_id=UCvjgXvBlbQiydffZU7m1_aw'));

    currentFeed = listChannels[0].linkFeed;
  }

  Future<void> changeFeed(String urlNewFeed) {
    setState(() {
      currentFeed = urlNewFeed;
    });
  }

  void openBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Wrap(children: [
            Card(
              margin: EdgeInsets.fromLTRB(50, 15, 50, 20),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[700], width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(
                  versaoNomeChangelog.nomeApp +
                      " " +
                      versaoNomeChangelog.versaoApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 1.2,
              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listChannels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    changeFeed(listChannels[index].linkFeed);
                  },
                  leading: Icon(Icons.video_library),
                  title: Text(
                    listChannels[index].name,
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                );
              },
            ),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListBuilder(
          key: UniqueKey(),
          feedUrl: currentFeed,
        ),
        bottomNavigationBar: BottomAppBar(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.refresh_outlined,
                    //size: 24,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    changeFeed(currentFeed);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.menu,
                    //size: 24,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    openBottomSheet();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.settings,
                    //size: 24,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Configs(),
                          fullscreenDialog: true,
                        ));
                  }),
            ],
          ),
        )));
  }
}
