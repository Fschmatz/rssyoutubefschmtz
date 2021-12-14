import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class ChannelDao {

  static const _databaseName = "YoutubeChannels.db";
  static const _databaseVersion = 1;

  static const table = 'channels';
  static const columnIdChannel = 'idChannel';
  static const columnChannelName = 'channelName';
  static const columnChannelLinkId = 'channelLinkId';

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  ChannelDao._privateConstructor();
  static final ChannelDao instance = ChannelDao._privateConstructor();


  // Open db and create if it not exists
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnIdChannel INTEGER PRIMARY KEY,            
            $columnChannelName TEXT NOT NULL,
            $columnChannelLinkId TEXT NOT NULL
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
    return await db.rawQuery('SELECT * FROM $table ORDER BY $columnChannelName');
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'))!;
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdChannel];
    return await db.update(table, row, where: '$columnIdChannel = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnIdChannel = ?', whereArgs: [id]);
  }
}