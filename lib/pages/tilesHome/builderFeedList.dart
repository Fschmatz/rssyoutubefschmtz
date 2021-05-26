import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/db/channelDao.dart';
import 'package:rssyoutubefschmtz/pages/saveEditChannel.dart';
import 'package:rssyoutubefschmtz/pages/tilesHome/videoCard.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class BuilderFeedList extends StatefulWidget {
  @override
  _BuilderFeedListState createState() => _BuilderFeedListState();

  final String feedUrl;
  final String channelName;
  final int index;

  int channelId;
  String channelLink;
  Function() refreshList;

  BuilderFeedList(
      {Key key,
      this.feedUrl,
      this.channelName,
      this.index,
      this.channelId,
      this.channelLink,
      this.refreshList})
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

  void deleteChannel(int id) async {
    final dbChannel = ChannelDao.instance;
    final delete = await dbChannel.delete(id);
  }

  showAlertDialogOkDelete(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        deleteChannel(widget.channelId);
        widget.refreshList();
        Navigator.of(context).pop();
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
      appBar: AppBar(
        title: Text(widget.channelName),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              showAlertDialogOkDelete(context);
            },
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => SaveEditChannel(
                          channelId: widget.channelId,
                          channelLink: widget.channelLink,
                          channelName: widget.channelName,
                          edit: true,
                        ),
                        fullscreenDialog: true,
                      ))
                  .then((value) =>
                      {widget.refreshList(), Navigator.of(context).pop()});
            },
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).hintColor,
            ),
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
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.3),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => getRssYoutubeData(),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: feedYoutube.length,
                    itemBuilder: (context, index) {
                      return FadeInUp(
                        duration: Duration(milliseconds: 600),
                        child: VideoCard(
                            showChannelName: false,
                            feed: new Feed(
                              title: feedYoutube[index].title,
                              link: feedYoutube[index].links[0].href,
                              author: feedYoutube[index].authors[0].name,
                              data: feedYoutube[index].published,
                              linkImagem:
                                  'https://i.ytimg.com/vi/${feedYoutube[index].id.substring(9)}/hq720.jpg',
                            )),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
    );
  }
}
