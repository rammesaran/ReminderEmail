import 'package:automatic_email_reminder/database/transaction_db.dart';
import 'package:automatic_email_reminder/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int index = 0;
  @override
  void initState() {
    super.initState();
    //helper.getTransaction();
  }

  DataBaseHelper helper = DataBaseHelper();

  List<TransactionModel> listOfModel = [
    TransactionModel(
      id: 1,
      transactionDescription: "Update Task",
      transactionStatus: "Success",
      dateTime: "20-08-2020",
    ),
    TransactionModel(
      id: 2,
      transactionDescription: "Update Status",
      transactionStatus: "Pending",
      dateTime: "20-08-2020",
    ),
    TransactionModel(
      id: 3,
      transactionDescription: "Update Person",
      transactionStatus: "Error",
      dateTime: "20-08-2020",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: "Send Email",
          child: Text(
            "Email",
          ),
          onPressed: () async {
            sendEmail(listOfModel, index);
          }),
      appBar: AppBar(
        title: Text('Transaction Details'),
        actions: [
          IconButton(
            tooltip: "Add Transactions",
            onPressed: () async {
              TransactionModel model =
                  listOfModel[math.Random().nextInt(listOfModel.length)];
              //listOfModel[1];
              await helper.insertTransaction(model);
              print(helper);
              var data = await helper.getTransaction();
              print(data);
              setState(() {});
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: helper.getTransaction(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  TransactionModel item = snapshot.data[index];
                  return ListTile(
                    leading: Text(item.id.toString()),
                    title: Text(item.transactionDescription),
                    subtitle: Text(item.dateTime),
                    trailing: Text(item.transactionStatus),
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

  void sendEmail(List<TransactionModel> model, int index) async {
    String username = 'rammesaran@gmail.com';
    String password = '******';

    final smptServer = gmail(username, password);

    final message = Message();
    message.from = Address(username);
    message.recipients.add('rajansaravana007@gmail.com');
    message.subject = 'This is subject';
    message.text =
        'Task ID is ${model[index].id}Task Description is ${model[index].transactionDescription} and Task Status is ${model[index].transactionStatus} and Task Date is ${model[index].dateTime}';

    try {
      final sendReport = await send(message, smptServer);
      print('Message is sent $sendReport');
    } on MailerException catch (e) {
      print(e);
    }
  }
}
