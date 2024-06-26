import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rssyoutubefschmtz/db/channelDao.dart';
import 'package:rssyoutubefschmtz/pages/channelList.dart';

class SaveEditChannel extends StatefulWidget {
  bool edit;
  int channelId;
  String channelName;
  String channelLink;

  SaveEditChannel(
      {Key key, this.edit, this.channelId, this.channelLink, this.channelName})
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
    if (widget.edit) {
      customControllerChannelName.text = widget.channelName;
      customControllerChannelIdLink.text = widget.channelLink;
    }
    super.initState();
  }

  void _saveChannel() async {
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
      child: Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblems(),
        style: TextStyle(
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
          title: Text("Add Channel"),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                icon: Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkProblems().isEmpty) {
                    if (!widget.edit) {
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
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 100,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: customControllerChannelName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.article_outlined, size: 20),
                      hintText: "Channel Name",
                      helperText: "* Required",
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 100,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: customControllerChannelIdLink,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.article_outlined, size: 20),
                      hintText: "Channel Id",
                      helperText: "* Required",
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Card(
                    elevation: 0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(
                        color: Colors.grey[600].withOpacity(0.5),
                      ),
                    ),
                    child: ListTile(
                        contentPadding:
                            const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        title: Text(
                          "How to get the Channel Id:\n\nOpen the channel page in the browser and copy the code after the ' = ' symbol.",
                          style: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.headline6.color.withOpacity(0.9)),
                        )),
                  )
                ])));
  }
}
