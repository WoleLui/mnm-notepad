import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'message_model.dart';
class MessageDatabase  {
  static final MessageDatabase  instance = MessageDatabase ._init();
  static Database? _database;

  MessageDatabase._init();

  // Initialisation de la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  // Création de la base de données
  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Création des tables dans la base de données
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        images TEXT,
        audio TEXT,
        isFavorite INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        background_image TEXT
      )
    ''');
  }

  Future<Message> insertMessage(Message message) async {
    final db = await instance.database;

    final id = await db.insert('messages', message.toJson());
    return message.copy(id: id);
  }

  Future<List<Message>> retrieveMessages() async {
    final db = await instance.database;

    final result = await db.query('messages');

    return result.map((json) => Message.fromJson(json)).toList();
  }

  Future<int> updateMessage(Message message) async {
    final db = await instance.database;

    return db.update(
      'messages',
      message.toJson(),
      where: 'id = ?',
      whereArgs: [message.id],
    );
  }

  Future<int> deleteMessage(int id) async {
    final db = await instance.database;

    return db.delete(
      'messages',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // Sauvegarder l'image de fond dans les paramètres
  Future<void> saveBackgroundImage(String imagePath) async {
    final db = await instance.database;
    await db.insert('settings', {'background_image': imagePath}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Récupérer l'image de fond sauvegardée
  Future<String?> getBackgroundImage() async {
    final db = await instance.database;
    final result = await db.query('settings', limit: 1);
    if (result.isNotEmpty) {
      return result.first['background_image'] as String?;
    }
    return null;
  }
}