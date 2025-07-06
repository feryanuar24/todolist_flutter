import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    return await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isDone INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final maps = await db.query('todos', where: 'isDone = ?', whereArgs: [0]);
    return maps.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Todo>> getCompletedTodos() async {
    final db = await database;
    final maps = await db.query('todos', where: 'isDone = ?', whereArgs: [1]);
    return maps.map((e) => Todo.fromMap(e)).toList();
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    return await db.insert('todos', todo.toMap());
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> toggleTodoStatus(int id, bool isDone) async {
    final db = await database;
    return await db.update(
      'todos',
      {'isDone': isDone ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
