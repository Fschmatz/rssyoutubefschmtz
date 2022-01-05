import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';

class SaveEditChannel extends StatefulWidget {
  bool? edit;
  int? channelId;
  String? channelName;
  String? channelLink;

  SaveEditChannel(
      {required Key key,
      this.edit,
      this.channelId,
      this.channelLink,
      this.channelName})
      : super(key: key);

  @override
  _SaveEditChannelState createState() => _SaveEditChannelState();
}

class _SaveEditChannelState extends State<SaveEditChannel> {
  TextEditingController customControllerChannelName = TextEditingController();
  TextEditingController customControllerChannelIdLink = TextEditingController();
  final dbChannel = ChannelDao.instance;

  @override
  void initState() {
    if (widget.edit!) {
      customControllerChannelName.text = widget.channelName!;
      customControllerChannelIdLink.text = widget.channelLink!;
    }
    super.initState();
  }

  void _saveChannel() async {
    print(
      customControllerChannelName.text,
    );
    print(
      customControllerChannelIdLink.text,
    );

    Map<String, dynamic> row = {
      ChannelDao.columnChannelName: customControllerChannelName.text,
      ChannelDao.columnChannelLinkId: customControllerChannelIdLink.text,
    };
    final id = await dbChannel.insert(row);
  }

  void _updateChannel() async {
    Map<String, dynamic> row = {
      ChannelDao.columnIdChannel: widget.channelId,
      ChannelDao.columnChannelName: customControllerChannelName.text,
      ChannelDao.columnChannelLinkId: customControllerChannelIdLink.text,
    };
    final update = await dbChannel.update(row);
  }

  String checkProblems() {
    String errors = "";
    if (customControllerChannelName.text.isEmpty) {
      errors += "Insert Channel Name\n";
    }
    if (customControllerChannelIdLink.text.isEmpty) {
      errors += "Insert Channel Id \n";
    }
    return errors;
  }

  showAlertDialogErrors(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: const Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblems(),
        style: const TextStyle(
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
          title: const Text("Add Channel"),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkProblems().isEmpty) {
                    if (!widget.edit!) {
                      _saveChannel();
                      Navigator.of(context).pop();
                    } else {
                      _updateChannel();
                      Navigator.of(context).pop();
                    }
                  } else {
                    showAlertDialogErrors(context);
                  }
                },
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const SizedBox(
                height: 0.1,
              ),
              title: Text("Channel Name".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            ListTile(
              leading: const Icon(Icons.notes_outlined),
              title: TextField(
                minLines: 1,
                maxLines: 5,
                maxLength: 100,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: customControllerChannelName,
                decoration: const InputDecoration(
                  helperText: "* Required",
                ),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              leading: const SizedBox(
                height: 0.1,
              ),
              title: Text("Channel Id".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: TextField(
                minLines: 1,
                maxLines: 5,
                maxLength: 200,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: customControllerChannelIdLink,
                decoration: const InputDecoration(
                  helperText: "* Required",
                ),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
           /* const SizedBox(
              height: 40,
            ),*/
            ListTile(
              leading: const SizedBox(
                height: 0.1,
              ),
              title: Text("Info".toUpperCase(),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: Text(
                  "How to get the Channel Id:\n\nOpen the channel page in the browser and copy the code after the ' = ' symbol.\n\nIf unavailable, open the page source code and search for externalId.",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.8)),
                ))
          ],
        ));
  }
}
