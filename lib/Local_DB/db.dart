import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../MVP/Model/post.dart';

final String TableName = 'POSTS';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'POSTS.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE POSTS(id INTEGER PRIMARY KEY,question TEXT,datetime TEXT,content TE XT,image_url BLOB)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insertPOST(POST post) async {
    final db = await database;

    await db.insert(
      TableName,
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<POST>> posts() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('POSTS');

    return List.generate(maps.length, (i) {
      return POST(
        id: maps[i]['id'],
        question: maps[i]['question'],
        datetime: maps[i]['datetime'],
        content: maps[i]['content'],
        image_url: maps[i]['image_url'],
      );
    });
  }

  Future<void> updatePOST(POST post) async {
    final db = await database;

    await db.update(
      TableName,
      post.toMap(),
      // Memo의 id가 일치하는 지 확인합니다.
      where: "id = ?",
      // Memo의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [post.id],
    );
  }

  Future<void> deletePOST(int id) async {
    final db = await database;

    await db.delete(
      TableName,
      // 특정 memo를 제거하기 위해 `where` 절을 사용하세요
      where: "id = ?",
      // Memo의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );
  }
}
