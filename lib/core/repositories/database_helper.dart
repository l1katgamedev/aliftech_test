import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/event_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  late Database _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'events.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE events(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            location TEXT,
            color INTEGER,
            datetime TEXT
          )
        ''');
      },
    );
  }

  Future<int> createEvent(EventModel event) async {
    final db = await database;
    return await db.insert('events', event.toMap());
  }

  Future<List<EventModel>> getAllEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (index) => EventModel.fromMap(maps[index]));
  }

  Future<int> updateEvent(EventModel event) async {
    final db = await database;
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(int id) async {
    final db = await database;
    return await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
