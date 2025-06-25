import 'dart:io';

import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{
  DBHelper._private();

  static final DBHelper instance = DBHelper._private();

  Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async{
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, 'game.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate
    );
  }

  Future<void> onCreate(Database db, int version) async{
     return await db.execute(
          '''
          CREATE TABLE game (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          developer TEXT NOT NULL,
          publisher TEXT NOT NULL,
          platform TEXT NOT NULL,
          image TEXT NOT NULL,
          genre TEXT NOT NULL
          )
          '''
        );
  }

  Future<Map<String,dynamic>> insertGame(ListAllGame game) async{
    try {
      final dbase = await db;
      final datas = await dbase.query(
        "game",
        where: 'id = ?',
        whereArgs: [game.id]
        );
        if (datas.isNotEmpty) throw "Game sudah ada di favorite!";

        final dataToinsert = {
          'id' : game.id,
          'title' : game.title,
          'developer' : game.developer,
          'publisher' : game.publisher,
          'platform' : game.platform,
          'description' : game.shortDescription,
          'image' : game.thumbnail,
          'genre' : game.genre
        };

        await dbase.insert("game", dataToinsert);
        return dataToinsert;
    } catch (e) {
       throw e.toString();
    }

  }

  Future<List<Map<String,dynamic>>?> getFavoviteGame() async{
    final dbase = await db;
    return await dbase.query("game");
  }

  Future<void> deleteFavMovie(int id) async{
    final dbase = await db;
    dbase.delete(
      "game",
      where: "id = ?",
      whereArgs: [id]
    );
    return;
  }
}