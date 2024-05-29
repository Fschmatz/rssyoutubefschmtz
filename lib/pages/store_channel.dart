import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';

class StoreChannel extends StatefulWidget {
  bool? edit;
  int? channelId;
  String? channelName;
  String? channelLink;

  StoreChannel({required Key key, this.edit, this.channelId, this.channelLink, this.channelName}) : super(key: key);

  @override
  _StoreChannelState createState() => _StoreChannelState();
}

class _StoreChannelState extends State<StoreChannel> {
  TextEditingController controllerChannelName = TextEditingController();
  TextEditingController controllerChannelId = TextEditingController();
  final dbChannel = ChannelDao.instance;
  bool validChannelName = true;
  bool validChannelId = true;

  @override
  void initState() {
    super.initState();
    if (widget.edit!) {
      controllerChannelName.text = widget.channelName!;
      controllerChannelId.text = widget.channelLink!;
    }
  }

  void _saveChannel() async {
    Map<String, dynamic> row = {
      ChannelDao.columnChannelName: controllerChannelName.text,
      ChannelDao.columnChannelLinkId: controllerChannelId.text,
    };

    await dbChannel.insert(row);
  }

  void _updateChannel() async {
    Map<String, dynamic> row = {
      ChannelDao.columnIdChannel: widget.channelId,
      ChannelDao.columnChannelName: controllerChannelName.text,
      ChannelDao.columnChannelLinkId: controllerChannelId.text,
    };

    await dbChannel.update(row);
  }

  bool validateTextFields() {
    bool ok = true;
    if (controllerChannelName.text.isEmpty) {
      ok = false;
      validChannelName = false;
    }
    if (controllerChannelId.text.isEmpty) {
      ok = false;
      validChannelId = false;
    }

    return ok;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.edit! ? const Text("Edit Channel") : const Text("Add Channel"),
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
                    border: const OutlineInputBorder(),
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
                    border: const OutlineInputBorder(),
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
                style: TextStyle(fontSize: 16, color: Theme.of(context).hintColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 25, 5),
              child: Text(
                "How to get the Channel Id:\n\nOpen the channel page in the browser and copy the code after the ' = ' symbol in the nav bar.\n\nIf unavailable, open the page source code and search for externalId.",
                style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: FilledButton.tonalIcon(
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
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text(
                    'Save',
                  )),
            ),
          ],
        ));
  }
}
