import 'package:flutter/material.dart';
import '../util/nameChangelog.dart';

class Changelog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Changelog"),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          Card(
            margin: EdgeInsets.fromLTRB(15, 12, 15, 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                //color: Colors.grey.withOpacity(0.8),
                width: 1,
              ),
            ),
            elevation: 0.0,
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 5),
              child: Text(
                NameChangelog.changelogUltimaVersao,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),

          Divider(thickness: 2,),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Previous Versions: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  NameChangelog.changelogsAntigos,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
