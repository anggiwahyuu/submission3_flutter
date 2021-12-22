import 'package:sqflite/sqflite.dart';

import '../model/restaurant_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
  static const String _favoriteTable = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_favoriteTable (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              city TEXT,
              pictureId TEXT,
              rating REAL
            )
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_favoriteTable, restaurant.toJson());
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favoriteTable);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }
}