import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';
import 'package:rssyoutubefschmtz/pages/store_channel.dart';
import 'package:rssyoutubefschmtz/widgets/video_details_card.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class SelectedChannelVideoList extends StatefulWidget {
  @override
  _SelectedChannelVideoListState createState() => _SelectedChannelVideoListState();

  final String feedUrl;
  final String channelName;
  final int index;

  int channelId;
  String channelLink;
  Function() refreshList;

  SelectedChannelVideoList(
      {required Key key,
      required this.feedUrl,
      required this.channelName,
      required this.index,
      required this.channelId,
      required this.channelLink,
      required this.refreshList})
      : super(key: key);
}

class _SelectedChannelVideoListState extends State<SelectedChannelVideoList> {
  bool loading = true;
  List<Feed> convertedFeedList = [];

  @override
  void initState() {
    super.initState();

    getRssYoutubeData();
  }

  //Each Youtube feed only returns 15 items
  Future<void> getRssYoutubeData() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(widget.feedUrl));
    try {
      var channel = AtomFeed.parse(response.body);
      Map<int, AtomItem> feedYoutube = channel.items!.asMap();

      convertedFeedList = feedYoutube.values.map((atomItem) {
        return Feed(
          title: atomItem.title!,
          link: atomItem.links![0].href!,
          author: atomItem.authors![0].name!,
          date: atomItem.published!,
          linkImagem: 'https://i.ytimg.com/vi/${atomItem.id!.substring(9)}/hq720.jpg',
        );
      }).toList();

      setState(() {
        loading = false;
      });

      client.close();
    } on Exception catch (_) {
      throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Feed ID Error'),
        duration: Duration(seconds: 4),
      ));
    }
  }

  void deleteChannel(int id) async {
    final dbChannel = ChannelDao.instance;

    await dbChannel.delete(id);
  }

  showAlertDialogOkDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirmation",
          ),
          content: const Text(
            "Delete Channel ?",
          ),
          actions: [
            TextButton(
              child: const Text(
                "Yes",
              ),
              onPressed: () {
                deleteChannel(widget.channelId);
                widget.refreshList();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
            ),
            onPressed: () {
              showAlertDialogOkDelete(context);
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => StoreChannel(
                      channelId: widget.channelId,
                      channelLink: widget.channelLink,
                      channelName: widget.channelName,
                      edit: true,
                      key: UniqueKey(),
                    ),
                  )).then((value) => {widget.refreshList(), Navigator.of(context).pop()});
            },
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),
      body: loading
          ? Visibility(
              visible: widget.index == 0,
              child: PreferredSize(
                preferredSize: const Size.fromHeight(4.0),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary.withOpacity(0.8)),
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => getRssYoutubeData(),
              child: (convertedFeedList.isEmpty)
                  ? const SizedBox.shrink()
                  : ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: convertedFeedList.length,
                          itemBuilder: (context, index) {
                            Feed feed = convertedFeedList[index];

                            return FadeInUp(
                              duration: const Duration(milliseconds: 600),
                              child: VideoDetailsCard(
                                key: UniqueKey(),
                                showChannelName: false,
                                feed: feed,
                              ),
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
