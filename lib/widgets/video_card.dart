import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/db/watch_later_dao.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:jiffy/jiffy.dart';

class VideoCard extends StatelessWidget {
  Feed feed;
  bool showChannelName;

  VideoCard({required Key key,required this.feed,required this.showChannelName}) : super(key: key);

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
      WatchLaterFeedDao.columnTitle: feed.title,
      WatchLaterFeedDao.columnLink: feed.link,
      WatchLaterFeedDao.columnAuthor: feed.author,
      WatchLaterFeedDao.columnDate: feed.data,
    };
    final id = await db.insert(row);
  }

  void delete() async {
    final db = WatchLaterFeedDao.instance;
  //  final delete = await db.delete(feed.id);
  }

  @override
  Widget build(BuildContext context) {
    var dataFormatada = Jiffy(feed.data).format("dd/MM/yyyy");

    return InkWell(
      onTap: () {
        _launchBrowser(feed.link.toString());
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
                      image: feed.linkImagem,
                      placeholder: "assets/placeholder.jpg")),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  feed.title,
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
                            visible: showChannelName,
                            child: Text(
                              feed.author,
                              style: TextStyle(
                                  fontSize: 13, color: Theme.of(context).hintColor),
                            ),
                          ),
                          Visibility(
                            visible:showChannelName,
                            child: const SizedBox(
                              height: 5,
                            ),
                          ),
                          Text(
                            dataFormatada,
                            style: TextStyle(
                                fontSize: 13, color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 55,
                      child: TextButton(
                        onPressed: () {
                          _saveVideoToWatchLater();
                        },
                        child: Icon(
                          Icons.watch_later_outlined,
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
                          onPrimary: Theme.of(context).colorScheme.secondaryVariant,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 55,
                      child: TextButton(
                          onPressed: () {
                            Share.share(feed.link);
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
                          onPrimary: Theme.of(context).colorScheme.secondaryVariant,
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

