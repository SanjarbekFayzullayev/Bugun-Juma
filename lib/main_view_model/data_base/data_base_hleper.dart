import 'dart:io';
import 'package:bugun_juma/main_view_model/data_base/muslim_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper intancee = DatabaseHelper._intance();
  static Database? _db;

  DatabaseHelper._intance();

  Future<Database?> get db async {
    return _db ?? await _intDB();
  }

  final String tableName = 'tableTodo';
  final String colId = 'id';
  final String colTitle = 'title';
  final String colDescription = 'description';
  final String colDate = 'time';

  Future<Database?> _intDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}todo.db";
    _db = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, version) async {
        db.execute("CREATE TABLE $tableName("
            "$colId INTEGER PRIMARY KEY,"
            "$colTitle TEXT,"
            "$colDescription TEXT,"
            "$colDate TEXT,"
            ")");
      },
    );
    return _db;
  }

  Future<Task> insert(Task task) async {
    final data = await db;
    task.id = await data?.insert(tableName, task.toMap());
    return task;
  }

  Future<List<Map<String, Object?>>?> getTaskMap() async {
    final data = await db;
    final List<Map<String, Object?>>? result = await data?.query(tableName);
    return result;
  }

  Future<List<Task>> getTask() async {
    final List<Map<String, Object?>>? taskMap = await getTaskMap();
    final List<Task> tasks = [];
    taskMap?.forEach((element) {
      tasks.add(Task.fromMap(element));
    });
    return tasks;
  }

  Future<int?> update(Task task) async {
    final data = await db;
    return await data?.update(tableName, task.toMap(),
        where: "$colId = ?", whereArgs: [task.id]);
  }

  Future<int?> delete(int taskId) async {
    final data = await db;
    return await data?.delete(
      tableName,
      where: "$colId = ?",
      whereArgs: [taskId],
    );
  }

  clearUserTable() async {
    final data = await db;
    return await data?.rawDelete("DELETE FROM $tableName");
  }
}
