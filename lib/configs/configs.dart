import 'package:flutter/material.dart';
import 'package:rssreaderfschmtz/configs/about.dart';
import 'package:rssreaderfschmtz/configs/changelog.dart';
import 'package:rssreaderfschmtz/util/theme.dart';
import '../util/versaoNomeChangelog.dart';
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
          centerTitle: true,
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
                elevation: 0,
                margin: const EdgeInsets.all(2.0),
                color: Colors.green,
                child: ListTile(
                  title: Text(
                    "Flutter " +
                        versaoNomeChangelog.nomeApp +
                        " " +
                        versaoNomeChangelog.versaoApp,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),

                ),
              ),
              SizedBox(
                height: 40.0,
              ),

              Column(
                children: <Widget>[

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.text_snippet_outlined),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        "About",
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => About()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.text_snippet_outlined),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        "Changelog",
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Changelog()),
                        );
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Options: ",
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(
                height: 15.0,
              ),

              ListTile(
                contentPadding: const EdgeInsets.all(0),
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


              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
