import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/models/task.dart';

class DbService {
  static final _instance = DbService._();
  static Database? _database;

  DbService._();
  factory DbService() => _instance;

  Future<Database> _createDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "task.db");

    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER NOT NULL";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id $idType,
            title $textType,
            description $textType,
            isCompleted $intType,
            category $textType,
            createdAt $textType
          )
        ''');
      },
    );
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _createDatabase();
    return _database!;
  }

  Future<Task> create({required Task todo}) async {
    final db = await database;
    final id = await db.insert("todos", todo.toMap());
    return todo.copyWith(id: id);
  }

  Future<int> update({required Task todo}) async {
    final db = await database;
    return await db.update(
      "todos",
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete("todos", where: "id = ?", whereArgs: [id]);
  }

  Future<List<Task>> readAllTasks() async {
    final db = await database;
    final mapList = await db.query("todos", orderBy: "createdAt DESC");
    return mapList.map((map) => Task.fromMap(map)).toList();
  }
}
