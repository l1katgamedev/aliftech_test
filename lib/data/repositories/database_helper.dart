import 'package:aliftech_test/data/models/event_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('event.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableEvents (
    ${DayEventFields.id} integer primary key autoincrement,
    ${DayEventFields.name} TEXT,
    ${DayEventFields.description} TEXT,
    ${DayEventFields.location} TEXT,
    ${DayEventFields.colorValue} INTEGER,
    ${DayEventFields.dateTime} TEXT)
    ''');
  }

  Future<DayEvent> create(DayEvent event) async {
    final db = await instance.database;
    final id = await db.insert(tableEvents, event.toJson());
    return event.copy(id: id);
  }

  Future<List<DayEvent>> readAll() async {
    final db = await instance.database;

    final result = await db.query(tableEvents);

    return result.map((e) => DayEvent.fromJson(e)).toList();
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;

    return await db.delete(
      tableEvents,
      where: '${DayEventFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabase() async {
    databaseFactory.deleteDatabase(tableEvents);
  }
}
