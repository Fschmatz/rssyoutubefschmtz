import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'db/db_creator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbCreator = DbCreator.instance;
  dbCreator.initDatabase();

  runApp(
    EasyDynamicThemeWidget(
      child: const AppTheme(),
    ),
  );
}

