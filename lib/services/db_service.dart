import 'package:flutter_application_1/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static final _instance = DbService._();
  static Database? _database;

  /// Private constructor
  DbService._();

  /// Create or access instance of DbService class
  factory DbService() => _instance;

  // create/open database
  Future<Database> _createdDatabase() async {
    // path
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "task.db");

    // table's column specific property
    const idType = "integer primary key autoincrement";
    const textType = "text not null";
    const intType = "integer not null";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table todos(
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

  // getter function to get the actual database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _createdDatabase();
    return _database!;
  }

  // insert
  Future<Task> create({required Task todo}) async {
    final db = await database;
    final id = await db.insert("todos", todo.toMap());
    return todo.copyWith(id: id);
  }

  // update
  Future<int> update({required Task todo}) async {
    final db = await database;
    return await db.update(
      "todos",
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }

  // delete
  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete("todos", where: "id = ?", whereArgs: [id]);
  }

  // read all => list of task data
  Future<List<Task>> readAllTasks() async {
    final db = await database;
    final mapList = await db.query("todos", orderBy: "createdAt desc");
    return mapList.map((map) => Task.fromMap(map)).toList();
  }
}
