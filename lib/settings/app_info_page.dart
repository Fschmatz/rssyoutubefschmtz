import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/util/changelog.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  _launchGithub()  {
    const url = 'https://github.com/Fschmatz/rssyoutubefschmtz';
    launch(url);
  }

  @override
  Widget build(BuildContext context) {

    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: const Text("App Info"),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.green[400],
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(Changelog.appName +" "+ Changelog.appVersion,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          const SizedBox(height: 15),
          const Divider(),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Dev".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          const ListTile(
            leading: Icon( Icons.info_outline),
            title: Text(
              "HAMMERED AND REDONE: 0.5 Times !!!",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text(
              "Application created using Flutter and the Dart language, used for testing and learning.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Source Code".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          ListTile(
            onTap: () {_launchGithub();},
            leading: const Icon(Icons.open_in_new_outlined),
            title: const Text("View on GitHub",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue)),
          ),
          const Divider(),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Quote".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: themeColorApp)),
          ),
          const ListTile(
            leading: Icon(Icons.messenger_outline),
            title: Text(
              "No one in the brief history of computing has ever written a piece of perfect software. It’s unlikely that you’ll be the first.\nAndy Hunt ",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ]));
  }
}
