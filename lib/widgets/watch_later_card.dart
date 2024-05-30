import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/watch_later_feed.dart';
import 'package:rssyoutubefschmtz/db/watch_later_dao.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:jiffy/jiffy.dart';

import '../util/utils.dart';

class WatchLaterCard extends StatelessWidget {
  WatchLaterFeed watchLaterFeed;
  Function() refreshList;

  WatchLaterCard({required Key key, required this.watchLaterFeed, required this.refreshList}) : super(key: key);

  void delete() async {
    final db = WatchLaterFeedDao.instance;
    await db.delete(watchLaterFeed.id);

    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Utils().launchBrowser(watchLaterFeed.link);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 5, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
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
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        watchLaterFeed.author,
                        style: TextStyle(fontSize: 12, color: theme.hintColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        watchLaterFeed.getFormattedDate(),
                        style: TextStyle(fontSize: 12, color: theme.hintColor, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 55,
                  child: IconButton(
                    onPressed: () {
                      delete();
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 22.0,
                      color: theme.hintColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 55,
                  child: IconButton(
                    onPressed: () {
                      Share.share(watchLaterFeed.link);
                    },
                    icon: Icon(
                      Icons.share_outlined,
                      size: 22.0,
                      color: theme.hintColor,
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
