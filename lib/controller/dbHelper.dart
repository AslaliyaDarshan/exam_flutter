import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? db;

  Future<Database> checkDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, "DatabaseApp.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE Student(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,quantity TEXT,image TEXT)";
        db.execute(query);
      },
    );
  }

  void insertData(String n1, String q1, String i1) async {
    db = await checkDatabase();
    print(n1);
    print(q1);
    print(i1);
    db!.insert(
      "Student",
      {"name": n1, "quantity": q1, "image": i1},
    );
  }

  Future<List<Map>> readData() async {
    db = await checkDatabase();
    String query = "SELECT * FROM Student";
    List<Map> studentList = await db!.rawQuery(query, null);
    return studentList;
  }

  void deleteData(String id) async {
    db = await checkDatabase();
    db!.delete("Student", where: "id = ?", whereArgs: [int.parse(id)]);
  }

  void updateData(String id, String n1, String q1, String i1) async {
    db = await checkDatabase();
    db!.update("Student", {"name": n1, "quantity": q1, "image": i1},
        where: "id = ?", whereArgs: [int.parse(id)]);
  }
}
