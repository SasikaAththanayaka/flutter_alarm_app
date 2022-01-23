import 'package:alarm_app/model/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'alarm';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDataBase();
    }
    return _database;
  }

  Future<Database> initializeDataBase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableName ( 
          $columnId integer primary key autoincrement,
          $columnDateTime text not null, 
          $columnTitle text not null,
          $columnPending integer)
        ''');
      },
    );

    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert('alarm', alarmInfo.toMap());
    //print("result :$result");
    print(result);
  }
}
