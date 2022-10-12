import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rssyoutubefschmtz/db/channel_dao.dart';

class PrintList extends StatefulWidget {
  PrintList({Key? key}) : super(key: key);

  @override
  _PrintListState createState() => _PrintListState();
}

class _PrintListState extends State<PrintList> {
  final db = ChannelDao.instance;
  bool loading = true;
  String formattedList = '';

  @override
  void initState() {
    super.initState();
    getPlaylists();
  }

  void getPlaylists() async {
    List<Map<String, dynamic>> list = await db.queryAllOrderByChannelName();

    for (int i = 0; i < list.length; i++) {
      formattedList += "\n" + list[i]['channelName'];
      formattedList += "\n" + list[i]['channelLinkId'] + "\n";
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print'),
        actions: [
          TextButton(
            child: const Text(
              "Copy",
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: formattedList));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        children: [
          (loading)
              ? const SizedBox.shrink()
              : SelectableText(
                  formattedList,
                  style: const TextStyle(fontSize: 16),
                ),
          const SizedBox(height: 30,)
        ],
      ),
    );
  }
}
