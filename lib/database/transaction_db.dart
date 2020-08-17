import 'dart:io';
import 'package:automatic_email_reminder/model/transaction_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDBProvider {
  static final TransactionDBProvider dbProvider = TransactionDBProvider();
  static Database _database;

  //default constrctor
  TransactionDBProvider();

  // to get the database instance
  Future<Database> get database async {
    if (database != null) return _database;

    _database = await initDataBase();
    return _database;
  }

  //Method to : Creating Database
  Future<Database> initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Transaction.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Transaction (
          id INTEGER PRIMARYKEY,
          description TEXT,
          transactionstatus TEXT,
          dateAndTime TEXT
          )
          ''');
      print('table created');
    });
  }

  //Method : Inserting the records

  insertTransaction(TransactionModel model) async {
    final db = await database;
    var res = await db.insert(
      "Transaction",
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  // Method : to get the transaction records
  Future<List<TransactionModel>> getTransaction() async {
    final db = await database;

    final List<Map<String, dynamic>> data = await db.query('Transaction');

    return List.generate(data.length, (index) {
      return TransactionModel(
        transactionid: data[index]['id'],
        transactionDescription: data[index]['description'],
        status: data[index]['transactionstatus'],
        datetime: data[index]['dateAndTime'],
      );
    });
  }
}
