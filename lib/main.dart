import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssyoutubefschmtz/app.dart';
import 'package:rssyoutubefschmtz/util/theme.dart';
import 'db/db_creator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbCreator = DbCreator.instance;
  dbCreator.initDatabase();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: Consumer<ThemeNotifier>(
      builder:(context, ThemeNotifier notifier, child){

        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: const App(),
          debugShowCheckedModeBanner: false,
        );
      },
    ),
  )
  );
}


