import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Salva as mensagens da tela Contato em SQLite.
class MessageDb {
  static Database? _db;

  static Future<Database> get _database async {
    return _db ??= await openDatabase(
      join(await getDatabasesPath(), 'graoeprosa.db'),
      version: 1,
      onCreate: (db, version) => db.execute(
        'CREATE TABLE messages ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'name TEXT NOT NULL, '
        'message TEXT NOT NULL, '
        'created_at TEXT NOT NULL)',
      ),
    );
  }

  static Future<void> insert(String name, String message) async {
    await (await _database).insert('messages', {
      'name': name,
      'message': message,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, Object?>>> all() async =>
      (await _database).query('messages', orderBy: 'id DESC');
}
