import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rssyoutubefschmtz/classes/channelFeed.dart';
import 'package:rssyoutubefschmtz/classes/feedListChannels.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/builderFeedList.dart';
import 'package:rssyoutubefschmtz/configs/configs.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/recentVideosFromAll.dart';
import 'package:rssyoutubefschmtz/util/nameChangelog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<ChannelFeed> listChannels = new FeedListChannels().getFeedListChannels();
  String currentFeed;
  bool recentVideosFromAll = true;
  String pageName;

  @override
  void initState() {
    super.initState();
    currentFeed = listChannels[0].linkFeed;
    pageName = "Recent Videos";
  }

  Future<void> changeFeed(String urlNewFeed) {
    setState(() {
      recentVideosFromAll = false;
      currentFeed = urlNewFeed;
    });
  }

  Future<void> changeFeedToRecents() {
    setState(() {
      recentVideosFromAll = true;
    });
  }

  void changePageName(String name){
    setState(() {
      pageName = name;
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
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Wrap(children: [
              Card(
                color: Theme.of(context).bottomAppBarColor,
                margin: EdgeInsets.fromLTRB(50, 15, 50, 20),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[700], width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    NameChangelog.nomeApp + " " + NameChangelog.versaoApp,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              ListTile(
                onTap: () {
                  changePageName("Recent Videos");
                  changeFeedToRecents();
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.new_releases_outlined),
                title: Text(
                  "Recent Videos",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              const Divider(
                thickness: 1.2,
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
                      changePageName(listChannels[index].name);
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
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(" "+pageName,
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                  fontSize: 19,
                  fontWeight: FontWeight.w600)),
        ),
        body:
        recentVideosFromAll ? RecentVideosFromAll(
          key: UniqueKey(),
        ) :
        BuilderFeedList(
          key: UniqueKey(),
          feedUrl: currentFeed,
          recents: false,
          index: 0,
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
                    Icons.menu_outlined,
                    //size: 24,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    openBottomSheet();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
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
