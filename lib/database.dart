import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TasksDatabaseHelper {
  static final TasksDatabaseHelper _instance = TasksDatabaseHelper.internal();

  factory TasksDatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  TasksDatabaseHelper.internal();

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks.db');
    print('Tasks Database path: $path'); // Adicione esta linha

    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            priority TEXT,
            dueDate TEXT,
            dueTime TEXT
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE tasks ADD COLUMN dueTime TEXT');
        }
      },
    );
  }
}

class UsersDatabaseHelper {
  static final UsersDatabaseHelper _instance = UsersDatabaseHelper.internal();

  factory UsersDatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  UsersDatabaseHelper.internal();

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'users.db');
    print('Users Database path: $path'); // Adicione esta linha

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }
}
