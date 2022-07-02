import 'package:sqflite/sqflite.dart';
// ignore: unnecessary_import
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:eling/model/tasks.dart';

class DbHelper {
    static final DbHelper _instance = DbHelper._internal();
    static Database? _database;
        
    //inisialisasi beberapa variabel yang dibutuhkan
    final String tableName = 'tb_tasks';
    final String columnId = 'taskID';
    final String columnCats = 'taskCats';
    final String columnName = 'taskName';
    final String columnDesc = 'taskDesc';
    final String columnTime = 'remindAt';

    DbHelper._internal();
    factory DbHelper() => _instance;
        
    //cek apakah database ada
    Future<Database?> get _db  async {
        if (_database != null) {
            return _database;
        }
        _database = await _initDb();
        return _database;
    }
        
    Future<Database?> _initDb() async {
        String databasePath = await getDatabasesPath();
        String path = join(databasePath, 'tasks.db');
        
        return await openDatabase(path, version: 1, onCreate: _onCreate);
    }
        
    //membuat tabel dan field-fieldnya
    Future<void> _onCreate(Database db, int version) async {
        var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
            "$columnCats TEXT,"
            "$columnName TEXT,"
            "$columnDesc TEXT,"
            "$columnTime TEXT)";
            await db.execute(sql);
    }
        
    //insert ke database
    Future<int?> storeTask(Tasks tasks) async {
        var dbClient = await _db;
        return await dbClient!.insert(tableName, tasks.toMap());
    }
        
  //read database
    Future<List?> getTasks() async {
        var dbClient = await _db;
        var result = await dbClient!.query(tableName, columns: [
            columnId,
            columnCats,
            columnName,
            columnDesc,
            columnTime
        ]);
        
        return result.toList();
    }
        
    //update database
    Future<int?> updateTasks(Tasks tasks) async {
        var dbClient = await _db;
        return await dbClient!.update(tableName, tasks.toMap(), where: '$columnId = ?', whereArgs: [tasks.id]);
    }
        
    //hapus database
    Future<int?> deleteTasks(int id) async {
        var dbClient = await _db;
        return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
    }
}