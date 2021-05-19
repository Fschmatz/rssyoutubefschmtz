import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/videoCard.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class HomeFeedList extends StatefulWidget {
  @override
  _HomeFeedListState createState() => _HomeFeedListState();

  final String feedUrl;
  final int index;

  HomeFeedList({Key key, this.feedUrl, this.index})
      : super(key: key);
}

class _HomeFeedListState extends State<HomeFeedList> {
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
    return carregando
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
        : SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return VideoCard(
              showChannelName: true,
              feed: new Feed(
                title: feedYoutube[index].title,
                link: feedYoutube[index].links[0].href,
                author: feedYoutube[index].authors[0].name,
                data: feedYoutube[index].published,
                linkImagem:
                'https://i.ytimg.com/vi/${feedYoutube[index].id.substring(9)}/hq720.jpg',
              ));
        },
      ),
    );
  }
}


