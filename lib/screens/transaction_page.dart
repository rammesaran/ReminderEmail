import 'package:automatic_email_reminder/database/transaction_db.dart';
import 'package:automatic_email_reminder/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    //helper.getTransaction();
  }

  DataBaseHelper helper = DataBaseHelper();

  List<TransactionModel> listOfModel = [
    TransactionModel(
        id: 1,
        transactionDescription: "this is firstDescription",
        transactionStatus: "This is first Status"),
    TransactionModel(
        id: 2,
        transactionDescription: "this is Second",
        transactionStatus: "This is Second Status"),
    TransactionModel(
        id: 3,
        transactionDescription: "this is third",
        transactionStatus: "This is Third Status"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        TransactionModel model =
            listOfModel[math.Random().nextInt(listOfModel.length)];

        await helper.insertTransaction(model);
        print(helper);
        var data = await helper.getTransaction();
        print(data);
        setState(() {});
      }),
      appBar: AppBar(),
      body: FutureBuilder<List<TransactionModel>>(
        future: helper.getTransaction(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  TransactionModel item = snapshot.data[index];
                  return ListTile(
                    title: Text(item.transactionDescription),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
