import 'dart:async';

import 'package:automatic_email_reminder/model/transaction_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  //create a database and table
  Future<Database> createDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'Transaction_database_new.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE TransactionDateTable("
          "id INTEGER, "
          "transactionDescription TEXT,"
          "transactionStatus TEXT,"
          "transactionTime TEXT"
          ")",
        );
      },
      version: 1,
    );
    return database;
  }

//insert the transaction
  Future<int> insertTransaction(TransactionModel model) async {
    final Database db = await createDatabase();

    var result = db.insert('TransactionDateTable', model.toMap());

    print(result);
    return result;
  }

//get the transaction
  Future<List<TransactionModel>> getTransaction() async {
    final Database db = await createDatabase();
    var res = await db.query('TransactionDateTable');
    List<TransactionModel> maps = res.isNotEmpty
        ? res.map((e) => TransactionModel.fromMap(e)).toList()
        : [];
    return maps;
    //var result = await db.rawQuery('SELECT * FROM TransactionTable ');
    //return result.toList();
    //print(result.toList());
    //final List<Map<String, dynamic>> maps = await db.query('TransactionTable');
    //return maps;

    // List<TransactionModel> list =
    //     res.isNotEmpty ? res.map((e) => TransactionModel.fromMap(e)) : null;
    //return list;
  }
}
