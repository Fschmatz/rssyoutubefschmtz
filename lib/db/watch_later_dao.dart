import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class WatchLaterFeedDao {

  static const _databaseName = "YoutubeRss.db";
  static const _databaseVersion = 1;

  static const table = 'watchLater';
  static const columnIdVideo = 'idVideo';
  static const columnTitle = 'title';
  static const columnLink = 'link';
  static const columnAuthor = 'author';
  static const columnDate = 'date';

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  WatchLaterFeedDao._privateConstructor();
  static final WatchLaterFeedDao instance = WatchLaterFeedDao._privateConstructor();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $columnIdVideo INTEGER PRIMARY KEY,            
            $columnTitle TEXT NOT NULL,
            $columnLink TEXT NOT NULL,
            $columnAuthor TEXT NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllOrderByChannelName() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY $columnAuthor');
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'))!;
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdVideo];
    return await db.update(table, row, where: '$columnIdVideo = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdVideo = ?', whereArgs: [id]);
  }
}