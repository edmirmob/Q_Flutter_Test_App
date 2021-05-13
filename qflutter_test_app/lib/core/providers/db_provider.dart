import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qflutter_test_app/core/models/comments.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database _database;
  static final DbProvider db = DbProvider._();

  DbProvider ._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'db_comments.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE CommentsTable (postId INTEGER, id INTEGER, name TEXT, email TEXT, body TEXT)');

        });
  }

  // Insert employee on database
  createComments(Comments comment) async {
    // await deleteAllEmployees();
    final db = await database;
    final res = await db.insert('CommentsTable', comment.toMap());

    return res;
  }


  Future<List<Comments>> getAllComments() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM CommentsTable");

    List<Comments> list =
    res.isNotEmpty ? res.map((coment) => Comments.fromMap(coment)).toList() : [];

    return list;
  }
}