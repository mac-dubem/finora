import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:finora/model/transaction.dart';

class DBService {
  static final DBService instance = DBService._constructor();
  factory DBService() => instance;
  DBService._constructor();

  static Database? _db;
  static const _dbName = 'transactions.db';
  static const _dbVersion = 2;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDataBase();
    return _db!;
  }

  Future<Database> getDataBase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        // create sheets table (sheet metadata)
        await db.execute('''
          CREATE TABLE sheets(
            id TEXT PRIMARY KEY,
            title TEXT,
            currency TEXT,
            amount TEXT,
            date TEXT
          )
        ''');

        // create transactions table (sheetId included for scoping)
        await db.execute('''
          CREATE TABLE  IF NOT EXISTS transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            type TEXT,
            category TEXT,
            description TEXT,
            date TEXT,
            sheetId TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Migration: add sheets table and sheetId column if upgrading from older version
        if (oldVersion < 2) {
          // add the new column for existing DBs
          await db.execute('''
            CREATE TABLE IF NOT EXISTS sheets(
              id TEXT PRIMARY KEY,
              title TEXT,
              currency TEXT,
              amount TEXT,
              date TEXT
            )
          ''');
          // Add column if it doesn't exist; wrap in try/catch to avoid errors
          try {
            await db.execute(
              'ALTER TABLE transactions ADD COLUMN sheetId TEXT',
            );
          } catch (_) {
            // column probably already exists or table missing; ignore
          }
        }
        // add future migrations here
      },
      onOpen: (db) async {
        // optional sanity checks or PRAGMA statements can go here
      },
    );
  }


  // ===============================================
  // New: create and fetch sheets
  // ===============================================
  Future<int> createSheet(Map<String, dynamic> sheet) async {
    final db = await database;
    return await db.insert(
      "sheets",
      sheet,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getSheets() async {
    final db = await database;
    return await db.query("sheets", orderBy: "date DESC");
  }

  Future<int> deleteSheet(String id) async {
    final db = await database;
    // remove sheet and optionally remove transactions belonging to it
    final cnt = await db.delete('sheets', where: 'id = ?', whereArgs: [id]);
    await db.delete('transactions', where: 'sheetId = ?', whereArgs: [id]);
    return cnt;
  }


  // -------------------------
  // Transactions methods
  // -------------------------

  Future<int> insertTransaction(TransactionModel tx) async {
    final db = await database;
    return await db.insert(
      "transactions",
      tx.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

   Future<int> updateTransaction(int id, Map<String, dynamic> values) async {
    final db = await database;
    return await db.update('transactions', values, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }


  Future<List<TransactionModel>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "transactions",
      orderBy: "date DESC",
    );
    return List.generate(maps.length, (i) => TransactionModel.fromMap(maps[i]));
  }

  // New: get transactions for a specific sheetId
  Future<List<TransactionModel>> getTransactionsForSheet(String sheetId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "transactions",
      where: "sheetId = ?",
      whereArgs: [sheetId],
      orderBy: "date DESC",
    );
    
    return List.generate(maps.length, (i) => TransactionModel.fromMap(maps[i]));
  }

   // -------------------------
  // Dev helper: delete DB file (useful during development)
  // -------------------------
  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    try {
      await deleteDatabase(path);
      _db = null;
    } catch (_) {
      // ignore
    }
  }
}
