import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/db/watch_later_dao.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:jiffy/jiffy.dart';

class VideoDetailsCard extends StatefulWidget {
  Feed feed;
  bool showChannelName;

  VideoDetailsCard(
      {Key? key, required this.feed, required this.showChannelName})
      : super(key: key);

  @override
  _VideoDetailsCardState createState() => _VideoDetailsCardState();
}

class _VideoDetailsCardState extends State<VideoDetailsCard> {
  List<Map<String, dynamic>> watchLaterList = [];

  @override
  void initState() {
    getWatchLaterList();
    super.initState();
  }

  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  void _saveVideoToWatchLater() async {
    final db = WatchLaterFeedDao.instance;
    Map<String, dynamic> row = {
      WatchLaterFeedDao.columnTitle: widget.feed.title,
      WatchLaterFeedDao.columnLink: widget.feed.link,
      WatchLaterFeedDao.columnAuthor: widget.feed.author,
      WatchLaterFeedDao.columnDate: widget.feed.data,
    };
    final id = await db.insert(row);
  }

  void _removeFromWatchLater() async {
    final db = WatchLaterFeedDao.instance;
    final delete = await db.delete(watchLaterList[0]['idVideo']);
  }

  Future<void> getWatchLaterList() async {
    final db = WatchLaterFeedDao.instance;
    var resp =
        await db.checkWatchLater(widget.feed.title);
    setState(() {
      watchLaterList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dataFormatada = Jiffy(widget.feed.data).format("dd/MM/yyyy");

    return InkWell(
      onTap: () {
        _launchBrowser(widget.feed.link.toString());
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: FadeInImage.assetNetwork(
                      image: widget.feed.linkImagem,
                      placeholder: "assets/placeholder.jpg")),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.feed.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Visibility(
                            visible: widget.showChannelName,
                            child: Text(
                              widget.feed.author,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).hintColor),
                            ),
                          ),
                          Visibility(
                            visible: widget.showChannelName,
                            child: const SizedBox(
                              height: 5,
                            ),
                          ),
                          Text(
                            dataFormatada,
                            style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 55,
                      child: TextButton(
                        onPressed: () {
                          watchLaterList.isEmpty
                          ? _saveVideoToWatchLater()
                          : _removeFromWatchLater();
                          getWatchLaterList();
                        },
                        child: Icon(
                          Icons.watch_later_outlined,
                          size: 20.0,
                          color: watchLaterList.isEmpty
                              ? Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .color!
                                  .withOpacity(0.9)
                              : Theme.of(context).colorScheme.primary,
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).cardTheme.color,
                          onPrimary:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 55,
                      child: TextButton(
                        onPressed: () {
                          Share.share(widget.feed.link);
                        },
                        child: Icon(
                          Icons.share_outlined,
                          size: 20.0,
                          color: Theme.of(context)
                              .textTheme
                              .headline6!
                              .color!
                              .withOpacity(0.9),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).cardTheme.color,
                          onPrimary:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
