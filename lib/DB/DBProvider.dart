import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:news_page_demo/Models/News.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider{
  // create  a private constructor (Prevent instatantiation)
  DBProvider._();
  static Database _db;
  //calling own constructor
  static final DBProvider dbProvider= DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_db != null) return _db;
    // If database don't exists, create one
    _db = await initDB();
    return _db;
  }
  initDB() async {
    // print("object");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'MyNews.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE News('
              'id INT PRIMARY KEY,'
              'title STRING,'
              'description STRING,'
              'tags STRING,'
              'saved INT,'
              'image STRING'
              ')');
        });
  }
  addNews(NewsDetail newsDetail) async {
    final db = await database;
    final res = await db.insert('News', newsDetail.toMap());
    return res;
  }

  Future<List<NewsDetail>> getAllSavedNews() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM News");
    List<NewsDetail> list = res.isNotEmpty ? res.map((c) => NewsDetail.fromMap(c)).toList() : [];
    return list;
  }
  deleteNews(int id) async{
    final db= await database;
    await db.delete('News',where: "id=?",whereArgs: [id]);
  }
}