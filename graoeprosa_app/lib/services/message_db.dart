import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactMessage {
  final int? id;
  final String name;
  final String message;
  final String createdAt;

  ContactMessage({
    this.id,
    required this.name,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'message': message,
      'created_at': createdAt,
    };
  }

  factory ContactMessage.fromMap(Map<String, dynamic> map) {
    return ContactMessage(
      id: map['id'] as int?,
      name: map['name'] as String,
      message: map['message'] as String,
      createdAt: map['created_at'] as String,
    );
  }
}

class MessageDb {
  static final MessageDb instance = MessageDb._init();
  static Database? _database;
  final List<ContactMessage> _webMemoryMessages = [];

  MessageDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'graoeprosa_messages.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            message TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
    return _database!;
  }

  Future<void> insertMessage(ContactMessage msg) async {
    if (kIsWeb) {
      _webMemoryMessages.insert(
        0,
        ContactMessage(
          id: _webMemoryMessages.length + 1,
          name: msg.name,
          message: msg.message,
          createdAt: msg.createdAt,
        ),
      );
      return;
    }

    final db = await database;
    await db.insert('messages', msg.toMap());
  }

  Future<List<ContactMessage>> getMessages() async {
    if (kIsWeb) {
      return List.unmodifiable(_webMemoryMessages);
    }

    final db = await database;
    final maps = await db.query('messages', orderBy: 'id DESC');
    return maps.map((m) => ContactMessage.fromMap(m)).toList();
  }
}
