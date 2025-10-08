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
      version: 1,
      onCreate: (db, version) async {
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

  // Future<int> deleteTransaction(int id) async {
  //   final db = await database;
  //   return await db.delete("transactions", where: "id = ?", whereArgs: [id]);
  // }
}
