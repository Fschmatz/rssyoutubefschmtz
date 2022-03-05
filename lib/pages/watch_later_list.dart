import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/watch_later_feed.dart';
import 'package:rssyoutubefschmtz/db/watch_later_dao.dart';
import 'package:rssyoutubefschmtz/widgets/app_bar_sliver.dart';
import 'package:rssyoutubefschmtz/widgets/watch_later_card.dart';

class WatchLaterList extends StatefulWidget {
  const WatchLaterList({required Key key}) : super(key: key);

  @override
  _WatchLaterListState createState() => _WatchLaterListState();
}

class _WatchLaterListState extends State<WatchLaterList> {
  List<Map<String, dynamic>> watchLaterList = [];

  @override
  void initState() {
    getWatchLaterList();
    super.initState();
  }

  Future<void> getWatchLaterList() async {
    final db = WatchLaterFeedDao.instance;
    var resp = await db.queryAllRows();
    setState(() {
      watchLaterList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[const AppBarSliver()];
        },
        body:
            ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            child: watchLaterList.isEmpty
                ? const SizedBox.shrink()
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    shrinkWrap: true,
                    itemCount: watchLaterList.length,
                    itemBuilder: (context, index) {
                      return WatchLaterCard(
                        watchLaterFeed: WatchLaterFeed(
                          id: watchLaterList[index]['idVideo'],
                          title: watchLaterList[index]['title'],
                          link: watchLaterList[index]['link'],
                          author: watchLaterList[index]['author'],
                          date: watchLaterList[index]['date'],
                        ),
                        key: UniqueKey(),
                        refreshList: getWatchLaterList,
                      );
                    }),
          ),
              const SizedBox(height: 50,)
        ]),
      ),
    );
  }
}
