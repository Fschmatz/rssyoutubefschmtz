import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';
import 'package:rssyoutubefschmtz/pages/saveEditChannel.dart';
import 'package:rssyoutubefschmtz/widgets/video_card.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class ChannelVideoList extends StatefulWidget {
  @override
  _ChannelVideoListState createState() => _ChannelVideoListState();

  final String feedUrl;
  final String channelName;
  final int index;

  int channelId;
  String channelLink;
  Function() refreshList;

  ChannelVideoList(
      {required Key key,
      required this.feedUrl,
      required this.channelName,
      required this.index,
      required this.channelId,
      required this.channelLink,
      required this.refreshList})
      : super(key: key);
}

class _ChannelVideoListState extends State<ChannelVideoList> {
  bool loading = true;
  Map<int, AtomItem> feedYoutube = {};

  @override
  void initState() {
    getRssYoutubeData();
    super.initState();
  }

  //Each Youtube feed only returns 15 items
  Future<void> getRssYoutubeData() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(widget.feedUrl));
    var channel = AtomFeed.parse(response.body);
    if (mounted) {
      setState(() {
        feedYoutube = channel.items!.asMap();
        loading = false;
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
      child: const Text(
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
      title: const Text(
        "Confirmation ", //
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content: const Text(
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
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
                          key: UniqueKey(),
                        ),
                        fullscreenDialog: true,
                      ))
                  .then((value) =>
                      {widget.refreshList(), Navigator.of(context).pop()});
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary.withOpacity(0.8)),
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => getRssYoutubeData(),
              child: feedYoutube.isEmpty
                  ? const SizedBox.shrink()
                  : ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: feedYoutube.length,
                          itemBuilder: (context, index) {
                            return FadeInUp(
                              duration: const Duration(milliseconds: 600),
                              child: VideoCard(
                                showChannelName: false,
                                feed: Feed(
                                  title: feedYoutube[index]!.title!,
                                  link: feedYoutube[index]!.links![0].href!,
                                  author: feedYoutube[index]!.authors![0].name!,
                                  data: feedYoutube[index]!.published!,
                                  linkImagem:
                                      'https://i.ytimg.com/vi/${feedYoutube[index]!.id!.substring(9)}/hq720.jpg',
                                ),
                                key: UniqueKey(),
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
