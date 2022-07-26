import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../MVP/Model/post.dart';
import '../MVP/Model/user_profile.dart';

final String TableName = 'USER';

class DB_USER_Helper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'USER.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE USER(id INTEGER PRIMARY KEY,profile_image BLOB)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<void> insertIMG(User_profile_image user_profile_image) async {
    final db = await database;

    await db.insert(
      TableName,
      user_profile_image.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<User_profile_image?> user_img() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('USER');

    if(maps.length == 0){
      return null;
    }else{
      return User_profile_image(
        id: 1,
        profile_image: maps[0]['profile_image'],
      );
    }


  }

  Future<void> updatePOST(User_profile_image user_profile_image) async {
    final db = await database;

    // 주어진 Memo를 수정합니다.
    await db.update(
      TableName,
      user_profile_image.toMap(),
      // Memo의 id가 일치하는 지 확인합니다.
      where: "id = ?",
      // Memo의 id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [user_profile_image.id],
    );
  }
//
// Future<void> deletePOST(int id) async {
//   final db = await database;
//
//   // 데이터베이스에서 Memo를 삭제합니다.
//   await db.delete(
//     TableName,
//     // 특정 memo를 제거하기 위해 `where` 절을 사용하세요
//     where: "id = ?",
//     // Memo의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
//     whereArgs: [id],
//   );
// }
}
