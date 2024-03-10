import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        time TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'muslimdata.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String title, String? description, String dateTime) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'description': description,'time':dateTime};
    final id = await db.insert('items', data);
    return id;
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return await db.query('items');
  }
  static Future<void> updateItem(int id, String title, String? description,String dateTime) async {
    final db = await SQLHelper.db();
    final data = {'title': title, 'description': description,'time':dateTime};
    await db.update('items', data, where: 'id = ?', whereArgs: [id]);
  }

 static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }


// Other CRUD methods go here...
}
