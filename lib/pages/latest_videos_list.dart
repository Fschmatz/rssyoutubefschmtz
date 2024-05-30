import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';
import 'package:rssyoutubefschmtz/widgets/app_bar_sliver.dart';
import 'package:rssyoutubefschmtz/widgets/video_details_card.dart';
import 'package:webfeed/domain/atom_feed.dart';
import 'package:webfeed/domain/atom_item.dart';
import 'package:http/http.dart' as http;

class LatestVideosList extends StatefulWidget {
  const LatestVideosList({Key? key}) : super(key: key);

  @override
  _LatestVideosListState createState() => _LatestVideosListState();
}

class _LatestVideosListState extends State<LatestVideosList> with AutomaticKeepAliveClientMixin<LatestVideosList> {
  bool loading = true;
  late String currentFeed;
  final dbChannel = ChannelDao.instance;
  List<Map<String, dynamic>> channelList = [];
  String urlYoutube = 'https://www.youtube.com/feeds/videos.xml?channel_id=';
  List<Feed> convertedFeedList = [];

  @override
  void initState() {
    super.initState();

    loadVideos();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> loadVideos() async {
    await getAllChannels();
    getRssYoutubeFeed();
  }

  Future<void> pullRefresh() async {
    convertedFeedList = [];
    setState(() {});
    getAllChannels().then((value) => getRssYoutubeFeed());
  }

  Future<void> getAllChannels() async {
    var resp = await dbChannel.queryAllOrderByChannelName();

    if (mounted) {
      setState(() {
        channelList = resp;
      });
    }
  }

  //Each Youtube feed only returns 15 items
  Future<void> getRssYoutubeFeed() async {
    List<AtomItem> listAllChannels = [];
    List<AtomItem> filteredList = [];
    var client = http.Client();

    for (int i = 0; i < channelList.length; i++) {
      var response = await client.get(Uri.parse(urlYoutube + channelList[i]['channelLinkId']));
      try {
        var channel = AtomFeed.parse(response.body);
        listAllChannels.addAll(channel.items!);
      } on Exception catch (_) {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Feed ID Error'),
          duration: Duration(seconds: 4),
        ));
      }
    }

    // Filter Feed
    for (int i = 0; i < listAllChannels.length; i += 15) {
      filteredList.addAll(listAllChannels.skip(i).take(1).toList());
    }

    // Convert Feed
    convertedFeedList = filteredList.map((atomItem) {
      return Feed(
        title: atomItem.title!,
        link: atomItem.links![0].href ?? "",
        author: atomItem.authors![0].name ?? "",
        date: atomItem.published!,
        linkImagem: 'https://i.ytimg.com/vi/${atomItem.id!.substring(9)}/hq720.jpg',
      );
    }).toList();

    // Order by date Desc
    if (convertedFeedList.isNotEmpty && convertedFeedList.length > 1) {
      convertedFeedList.sort((a, b) {
        DateTime dateA = DateTime.parse(a.date);
        DateTime dateB = DateTime.parse(b.date);
        return dateB.compareTo(dateA);
      });
    }

    setState(() {
      loading = false;
    });

    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => pullRefresh(),
            child: ListView(children: [
              (loading)
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: convertedFeedList.length,
                      itemBuilder: (context, index) {
                        Feed feed = convertedFeedList[index];

                        return FadeInUp(
                          duration: const Duration(milliseconds: 450),
                          child: VideoDetailsCard(
                            key: UniqueKey(),
                            showChannelName: true,
                            feed: feed,
                          ),
                        );
                      },
                    ),
              const SizedBox(
                height: 50,
              )
            ]),
          );
  }
}
