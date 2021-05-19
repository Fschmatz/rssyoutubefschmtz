import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:jiffy/jiffy.dart';

class VideoCard extends StatelessWidget {
  Feed feed;
  bool showChannelName;

  VideoCard({Key key, this.feed, this.showChannelName}) : super(key: key);

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
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: FadeInImage.assetNetwork(
                    image: feed.linkImagem,
                    placeholder: "assets/placeholder.jpg")),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  feed.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
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
                        icon: Icon(Icons.share_outlined),
                        color: Theme.of(context).hintColor,
                        constraints: BoxConstraints(),
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

