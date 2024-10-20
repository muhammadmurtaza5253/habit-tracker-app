import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Singleton pattern to ensure only one instance of the database is created
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Create and open the database
  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'habit_database.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create tables in the database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE habit_table (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      penalty TEXT NOT NULL,
      add_date TEXT NOT NULL,
      penalty_paid INTEGER NOT NULL DEFAULT 0
    )
  ''');
  }

  // Insert a new record
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;

    // Extract the current date in the format dd/mm/yyyy
    String formattedDate = DateTime.now()
        .toLocal()
        .toString()
        .split(' ')[0]
        .split('-')
        .reversed
        .join('/');

    // Add the 'add_date' to the row
    row['add_date'] = formattedDate;
    row['penalty_paid'] = 0;

    return await db.insert('habit_table', row);
  }

  // Fetch all records
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await database;
    return await db.query('habit_table');
  }

  Future<List<Map<String, dynamic>>> queryLastWeekHabits() async {
    Database db = await database;

    // Get the current date and the date 7 days ago in the same format
    String today = DateTime.now()
        .toLocal()
        .toString()
        .split(' ')[0]
        .split('-')
        .reversed
        .join('/');
    String sevenDaysAgo = DateTime.now()
        .subtract(const Duration(days: 7))
        .toLocal()
        .toString()
        .split(' ')[0]
        .split('-')
        .reversed
        .join('/');

    // Query habits that were created within the last 7 days
    return await db.query(
      'habit_table',
      where: 'add_date >= ? AND add_date <= ?',
      whereArgs: [sevenDaysAgo, today],
    );
  }

  // Update a record
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db
        .update('habit_table', row, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a record
  Future<int> delete(int? id) async {
    Database db = await database;
    if (id != null) {
      return await db.delete('habit_table', where: 'id = ?', whereArgs: [id]);
    }
    return 0;
  }

  // Close the database
  Future<void> close() async {
    Database db = await database;
    await db.close();
  }
}
