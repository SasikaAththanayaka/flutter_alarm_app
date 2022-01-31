import 'package:alarm_app/model/alarm_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AlarmHelper {
  Database _database;

  Future<Database> get database async {
    var dbpath = await getDatabasesPath();
    const dbName = "alarm.db";
    final path = join(dbpath, dbName);
    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE alarm(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        ispending INTEGER ,
        alarmDateTime Text   
      )
    ''');
  }

  Future<void> insertTodo(AlarmInfo alarmInfo) async {
    final db = await database;
    await db.insert(
      'alarm',
      alarmInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(
      'alarm',
      where: 'id == ?',
      whereArgs: [id],
    );
  }

  Future<void> updateTodo(AlarmInfo alarmInfo) async {
    final db = await database;
    await db.update(
      'alarm',
      alarmInfo.toMap(),
      where: 'id == ?',
      whereArgs: [alarmInfo.id],
    );
  }

  Future<List<AlarmInfo>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      'alarm',
      orderBy: 'id DESC',
    );
    return List.generate(
        items.length,
        (index) => AlarmInfo(
              id: items[index]['id'],
              title: items[index]['title'],
              isPending: items[index]['isPending'],
              alarmDateTime: DateTime.parse(items[index]['alarmDateTime']),
            ));
  }
}
