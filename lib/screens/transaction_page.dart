import 'package:automatic_email_reminder/database/transaction_db.dart';
import 'package:automatic_email_reminder/model/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
        future: TransactionDBProvider.dbProvider.getTransaction(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TransactionModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  TransactionModel transactionModel = snapshot.data[index];
                  return ListTile(
                    title: Text(transactionModel.transactionDescription),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
