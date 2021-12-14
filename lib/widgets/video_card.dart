import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
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
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey[850]!,
                ),
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(const Radius.circular(12)),
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
                    IconButton(
                        icon: const Icon(Icons.share_outlined),
                        color: Theme.of(context).hintColor,
                        constraints: const BoxConstraints(),
                        iconSize: 22,
                        splashRadius: 28,
                        onPressed: () {
                          Share.share(feed.link);
                        }),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

