import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssyoutubefschmtz/app.dart';
import 'package:rssyoutubefschmtz/util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: Consumer<ThemeNotifier>(
      builder:(context, ThemeNotifier notifier, child){

        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const App(),
        );
      },
    ),
  )
  );
}


