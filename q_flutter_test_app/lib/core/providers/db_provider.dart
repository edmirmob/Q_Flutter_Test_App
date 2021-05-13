import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/http.dart';
import '../models/comments.dart';

class DbProvider with Http {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'db_comments.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE CommentsTable (postId INTEGER, id INTEGER, name TEXT, email TEXT, body TEXT)');
    });
  }

  createComments(Comments comment) async {
    final db = await database;
    final res = await db.insert('CommentsTable', comment.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return res;
  }

  Future<List<Comments>> getAllComments() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var items = <Comments>[];

    if (connectivityResult == ConnectivityResult.none) {
      final db = await database;
      final res = await db.rawQuery("SELECT * FROM CommentsTable");

      items = res.isNotEmpty
          ? res.map((coment) => Comments.fromMap(coment)).toList()
          : [];
    } else if (connectivityResult != ConnectivityResult.none) {
      var url = Uri.https(
        'jsonplaceholder.typicode.com',
        '/comments',
      );
      final response = await get(url);

      response.forEach((entity) {
        items.add(Comments.fromMap(entity));
      });
    }
    return items;
  }
}
