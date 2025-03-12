import 'package:ai_chat_app/chat.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'chat_message.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE chats(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        createdAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE chat_messages(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        chatId INTEGER,
        role TEXT,
        content TEXT,
        timestamp TEXT,
        FOREIGN KEY (chatId) REFERENCES chats (id)
      )
    ''');
  }

  //  Methods for Chats

  Future<int> insertChat(Chat chat) async {
    Database? db = await database;
    return await db.insert('chats', chat.toMap());
  }

  Future<List<Chat>> getChats() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('chats');
    return List.generate(maps.length, (i) {
      return Chat.fromMap(maps[i]);
    });
  }

  Future<void> deleteChat(int chatId) async {
    final db = await database;
    await db.delete(
      'chats',
      where: 'id = ?',
      whereArgs: [chatId],
    );
  }

  //  Methos for mesagges

  Future<int> insertMessage(ChatMessage message) async {
    Database db = await database;
    return await db.insert('chat_messages', message.toMap());
  }

  Future<List<ChatMessage>> getMessagesForChat(int chatId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'chat_messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
    return List.generate(maps.length, (i) {
      return ChatMessage.fromMap(maps[i]);
    });
  }

  Future<void> deleteMessagesFromChat(int chatId) async {
    final db = await database;
    await db.delete(
      'chat_messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
    );
  }
}