import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/classes/feed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:jiffy/jiffy.dart';

class ContainerItemHome extends StatelessWidget {
  Feed feed;

  ContainerItemHome(
      {Key key, this.feed})
      : super(key: key);

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

    var dataFormatada = Jiffy(feed.data).format( "dd/MM/yyyy");

    return Card(
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        onTap: () {
          _launchBrowser(feed.link.toString());
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: FadeInImage.assetNetwork(
                image: feed.linkImagem,
                placeholder:"assets/placeholder.jpg"
              )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  feed.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dataFormatada,
                      style: TextStyle(fontSize: 13.5,color: Theme.of(context).hintColor),
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
