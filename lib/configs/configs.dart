import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/configs/about.dart';
import 'package:rssyoutubefschmtz/configs/changelog.dart';
import 'package:rssyoutubefschmtz/util/theme.dart';
import '../util/nameChangelog.dart';
import 'package:provider/provider.dart';

class Configs extends StatefulWidget {
  @override
  _ConfigsState createState() => _ConfigsState();

  Configs({Key key}) : super(key: key);
}

class _ConfigsState extends State<Configs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.all(2.0),
                    color: Color(0xFFDF5B51),
                    child: ListTile(
                      title: Text(
                        "Flutter " +
                            NameChangelog.nomeApp +
                            " " +
                            NameChangelog.versaoApp,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Column(
                    children: <Widget>[
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          leading: Icon(Icons.text_snippet_outlined),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(
                            "About",
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => About(),
                                  fullscreenDialog: true,
                                ));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          leading: Icon(Icons.text_snippet_outlined),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(
                            "Changelog",
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      Changelog(),
                                  fullscreenDialog: true,
                                ));
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      "Options: ",
                      style: TextStyle(fontSize: 19.5),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    title: Text(
                      "Dark Theme",
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Consumer<ThemeNotifier>(
                      builder: (context, notifier, child) => Switch(
                          activeColor: Colors.blue,
                          value: notifier.darkTheme,
                          onChanged: (value) {
                            notifier.toggleTheme();
                          }),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
