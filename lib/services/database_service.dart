import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:finora/model/transaction.dart';

class DBService {
  static final DBService instance = DBService._constructor();
  factory DBService() => instance;
  DBService._constructor();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDataBase();
    return _db!;
  }

  Future<Database> getDataBase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "transactions.db");

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE sheets(
            id TEXT PRIMARY KEY,
            title TEXT,
            currency TEXT,
            amount TEXT,
            date TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            type TEXT,
            category TEXT,
            description TEXT,
            date TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // add the new column for existing DBs
          await db.execute('ALTER TABLE transactions ADD COLUMN sheetId TEXT');
        }
        // add future migrations here
      },
    );
  }

  Future<int> insertTransaction(TransactionModel tx) async {
    final db = await database;
    return await db.insert(
      "transactions",
      tx.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  // New: create and fetch sheets
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

  // Future<int> deleteTransaction(int id) async {
  //   final db = await database;
  //   return await db.delete("transactions", where: "id = ?", whereArgs: [id]);
  // }
}
