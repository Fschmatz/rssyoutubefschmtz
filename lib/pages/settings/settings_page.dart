import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:rssyoutubefschmtz/pages/print_list.dart';
import 'package:rssyoutubefschmtz/util/app_details.dart';
import '../../util/dialog_select_theme.dart';
import '../../util/utils_functions.dart';
import 'app_info_page.dart';
import 'changelog_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

  const SettingsPage({Key? key}) : super(key: key);
}

class _SettingsPageState extends State<SettingsPage> {
  String getThemeStringFormatted() {
    String theme = EasyDynamicTheme.of(context)
        .themeMode
        .toString()
        .replaceAll('ThemeMode.', '');
    if (theme == 'system') {
      theme = 'system default';
    }
    return capitalizeFirstLetterString(theme);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColorApp = Theme.of(context).colorScheme.primary;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 1,
              margin: const EdgeInsets.fromLTRB(16, 20, 16, 25),
              color: themeColorApp,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ListTile(
                title: Text(
                  "${AppDetails.appName} ${AppDetails.appVersion}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17.5,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            ListTile(
              title: Text("General",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: themeColorApp)),
            ),
            ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DialogSelectTheme();
                  }),
              leading: const Icon(Icons.brightness_6_outlined),
              title: const Text(
                "App theme",
              ),
              subtitle: Text(
                getThemeStringFormatted(),
              ),
            ),
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PrintList(),
                  )),
              leading: const Icon(Icons.print_outlined),
              title: const Text(
                "Print channel list",
              ),
            ),
            ListTile(
              title: Text("About",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: themeColorApp)),
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
              ),
              title: const Text(
                "App info",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const AppInfoPage(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.text_snippet_outlined,
              ),
              title: const Text(
                "Changelog",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const ChangelogPage(),
                    ));
              },
            ),
          ],
        ));
  }
}
