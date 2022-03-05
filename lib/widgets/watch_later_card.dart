import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/watch_later_feed.dart';
import 'package:rssyoutubefschmtz/db/watch_later_dao.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:jiffy/jiffy.dart';

class WatchLaterCard extends StatelessWidget {
  WatchLaterFeed watchLaterFeed;
  Function() refreshList;

  WatchLaterCard({required Key key,required this.watchLaterFeed,required this.refreshList}) : super(key: key);

  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  void delete() async {
    final db = WatchLaterFeedDao.instance;
    final delete = await db.delete(watchLaterFeed.id);
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    var dataFormatada = Jiffy(watchLaterFeed.date).format("dd/MM/yyyy");

    return InkWell(
      onTap: () {
        _launchBrowser(watchLaterFeed.link.toString());
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 5, 5, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  watchLaterFeed.title,
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
                          Text(
                            watchLaterFeed.author,
                            style: TextStyle(
                                fontSize: 13, color: Theme.of(context).hintColor),
                          ),
                          const SizedBox(
                            height: 5,
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
                          delete();
                        },
                        child: Icon(
                          Icons.delete_outline,
                          size: 21.0,
                          color: Theme.of(context)
                              .textTheme
                              .headline6!
                              .color!
                              .withOpacity(0.9),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Theme.of(context).cardTheme.color,
                          onPrimary: Theme.of(context).colorScheme.secondary,
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
                            Share.share(watchLaterFeed.link);
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
                          onPrimary: Theme.of(context).colorScheme.secondary,
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

