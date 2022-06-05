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
  TextEditingController controllerChannelName = TextEditingController();
  TextEditingController controllerChannelId = TextEditingController();
  final dbChannel = ChannelDao.instance;
  bool validChannelName = true;
  bool validChannelId = true;

  @override
  void initState() {
    if (widget.edit!) {
      controllerChannelName.text = widget.channelName!;
      controllerChannelId.text = widget.channelLink!;
    }
    super.initState();
  }

  void _saveChannel() async {
    Map<String, dynamic> row = {
      ChannelDao.columnChannelName: controllerChannelName.text,
      ChannelDao.columnChannelLinkId: controllerChannelId.text,
    };
    final id = await dbChannel.insert(row);
  }

  void _updateChannel() async {
    Map<String, dynamic> row = {
      ChannelDao.columnIdChannel: widget.channelId,
      ChannelDao.columnChannelName: controllerChannelName.text,
      ChannelDao.columnChannelLinkId: controllerChannelId.text,
    };
    final update = await dbChannel.update(row);
  }



  String checkProblems() {
    String errors = "";
    if (controllerChannelName.text.isEmpty) {
      errors += "Insert Channel Name\n";
    }
    if (controllerChannelId.text.isEmpty) {
      errors += "Insert Channel Id \n";
    }
    return errors;
  }

  bool validateTextFields() {
    String errors = "";
    if (controllerChannelName.text.isEmpty) {
      errors += "Title";
      validChannelName = false;
    }
    if (controllerChannelId.text.isEmpty) {
      errors += "Title";
      validChannelId = false;
    }
    return errors.isEmpty ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.edit!
              ? const Text("Edit Channel")
              : const Text("Add Channel"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save_outlined),
              tooltip: 'Save',
              onPressed: () {

                if (validateTextFields()) {
                  if (!widget.edit!) {
                    _saveChannel();
                    Navigator.of(context).pop();
                  } else {
                    _updateChannel();
                    Navigator.of(context).pop();
                  }
                } else {
                  setState(() {
                    validChannelId;
                    validChannelName;
                  });
                }
              }
            ),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                minLines: 1,
                maxLines: 5,
                maxLength: 100,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: controllerChannelName,
                decoration: InputDecoration(
                    labelText: "Name",
                    helperText: "* Required",
                    counterText: "",
                    errorText: (validChannelName) ? null : "Name is empty"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                minLines: 1,
                maxLines: 5,
                maxLength: 200,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                controller: controllerChannelId,
                decoration: InputDecoration(
                    labelText: "Channel Id",
                    helperText: "* Required",
                    counterText: "",
                    errorText: (validChannelId) ? null : "Channel Id is empty"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 25, 5),
              child: Text(
                "Info",
                style:
                    TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 25, 5),
              child: Text(
                "How to get the Channel Id:\n\nOpen the channel page in the browser and copy the code after the ' = ' symbol.\n\nIf unavailable, open the page source code and search for externalId.",
                style:
                    TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
              ),
            ),
          ],
        ));
  }
}
