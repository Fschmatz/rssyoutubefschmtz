import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/db/watch_later_dao.dart';
import 'package:share/share.dart';
import 'package:jiffy/jiffy.dart';

import '../util/utils.dart';

class VideoDetailsCard extends StatefulWidget {
  Feed feed;
  bool showChannelName;

  VideoDetailsCard({Key? key, required this.feed, required this.showChannelName}) : super(key: key);

  @override
  _VideoDetailsCardState createState() => _VideoDetailsCardState();
}

class _VideoDetailsCardState extends State<VideoDetailsCard> {
  List<Map<String, dynamic>> watchLaterList = [];
  BorderRadius cardBorderRadius = BorderRadius.circular(12);

  @override
  void initState() {
    super.initState();
    getWatchLaterList();
  }

  void _saveVideoToWatchLater() async {
    final db = WatchLaterFeedDao.instance;
    Map<String, dynamic> row = {
      WatchLaterFeedDao.columnTitle: widget.feed.title,
      WatchLaterFeedDao.columnLink: widget.feed.link,
      WatchLaterFeedDao.columnAuthor: widget.feed.author,
      WatchLaterFeedDao.columnDate: widget.feed.data,
    };

    await db.insert(row);
  }

  void _removeFromWatchLater() async {
    final db = WatchLaterFeedDao.instance;
    await db.delete(watchLaterList[0]['idVideo']);
  }

  Future<void> getWatchLaterList() async {
    final db = WatchLaterFeedDao.instance;
    var resp = await db.checkWatchLater(widget.feed.title);
    setState(() {
      watchLaterList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var formattedDate = Jiffy(widget.feed.data).format("dd/MM/yyyy");

    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: cardBorderRadius,
        onTap: () {
          Utils().launchBrowser(widget.feed.link);
        },
        child: Column(
          children: [
            ClipRRect(
                borderRadius: cardBorderRadius,
                child: FadeInImage.assetNetwork(image: widget.feed.linkImagem, placeholder: "assets/placeholder.jpg")),
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: widget.showChannelName,
                        child: Text(
                          widget.feed.author,
                          style: TextStyle(fontSize: 12, color: theme.hintColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Visibility(
                        visible: widget.showChannelName,
                        child: const SizedBox(
                          height: 1,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 12, color: theme.hintColor, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 55,
                  child: IconButton(
                    onPressed: () {
                      watchLaterList.isEmpty ? _saveVideoToWatchLater() : _removeFromWatchLater();
                      getWatchLaterList();
                    },
                    icon: Icon(
                      Icons.watch_later_outlined,
                      size: 22.0,
                      color: watchLaterList.isEmpty ? theme.hintColor : Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 55,
                  child: IconButton(
                    icon: Icon(Icons.share_outlined, size: 22.0, color: theme.hintColor),
                    onPressed: () {
                      Share.share(widget.feed.link);
                    },
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
