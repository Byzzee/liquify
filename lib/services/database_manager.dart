import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  static final DatabaseManager _singleton = DatabaseManager._internal();
  factory DatabaseManager() {
    return _singleton;
  }
  DatabaseManager._internal();

  Database _database;

  Future<Database> openNewDatabase(String dbName) async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, dbName);
    var exists = await databaseExists(dbPath);

    if (!exists) {
      try {
        await Directory(dirname(dbPath)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "app.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(dbPath).writeAsBytes(bytes, flush: true);
    }

    _database = await openDatabase(dbPath);
    return _database;
  }

  void updateInDatabase(String table, Map<String,dynamic> values) async {
    await _database.update(table, values);
  }

  void insertInDatabase(String table, Map<String,dynamic> values) async {
    await _database.insert(table, values);
  }

  Future<Map> getSettingsFromDatabase() async {
    List<Map> presets = await _database.query('Settings');
    return presets[0];
  }
}