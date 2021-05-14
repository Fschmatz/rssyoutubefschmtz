import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/containerItemHome.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class BuilderFeedList extends StatefulWidget {
  @override
  _BuilderFeedListState createState() => _BuilderFeedListState();

  final String feedUrl;
  final String channelName;
  final int index;

  BuilderFeedList({Key key, this.feedUrl,this.channelName, this.index})
      : super(key: key);
}

class _BuilderFeedListState extends State<BuilderFeedList> {
  bool carregando = true;
  Map<int, AtomItem> feedYoutube = new Map();

  @override
  void initState() {
    getRssYoutubeData();
    super.initState();
  }

  //Feed do Youtube sempre será de 15 items
  Future<void> getRssYoutubeData() async {
    var client = http.Client();
    var response = await client.get(widget.feedUrl);
    var channel = AtomFeed.parse(response.body);
    if (mounted) {
      setState(() {
        feedYoutube = channel.items.asMap();
        carregando = false;
      });
    }
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() {
                carregando = true;
              });
              getRssYoutubeData();
            },
          ),
        ],
      ),
      body: carregando
          ? Visibility(
        visible: widget.index == 0,
        child: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).accentColor.withOpacity(0.8)),
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
          ),
        ),
      )
          : ListView(
        physics: AlwaysScrollableScrollPhysics(),
            children: [
              ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: feedYoutube.length,
                    itemBuilder: (context, index) {
                      return ContainerItemHome(
                          feed: new Feed(
                            title: feedYoutube[index].title,
                            link: feedYoutube[index].links[0].href,
                            data: feedYoutube[index].published,
                            linkImagem:
                            'https://i.ytimg.com/vi/${feedYoutube[index].id.substring(9)}/hq720.jpg',
                          ));
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
