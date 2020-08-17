import 'package:automatic_email_reminder/database/transaction_db.dart';
import 'package:automatic_email_reminder/model/transaction_model.dart';
import 'package:automatic_email_reminder/screens/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:math' as math;

void main() {
  //sendEmail();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    insertData();
    TransactionDBProvider.dbProvider.initDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: TransactionScreen(),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          setState(() {});
        }),
      ),
    );
  }
}

insertData() async {
  TransactionModel model =
      transactionData[math.Random().nextInt(transactionData.length)];
  await TransactionDBProvider.dbProvider.insertTransaction(model);
}

List<TransactionModel> transactionData = [
  TransactionModel(
      transactionid: 1,
      transactionDescription: "This is one description",
      status: TransactionStatus.success,
      datetime: '20/01/2008,'),
  TransactionModel(
      transactionid: 2,
      transactionDescription: "This is Two description",
      status: TransactionStatus.error,
      datetime: '10/05/2010,'),
];

void sendEmail() async {
  String username = 'rammesaran@gmail.com';
  String password = 'Ramsaran1';

  final smptServer = gmail(username, password);

  final message = Message();
  message.from = Address(username);
  message.recipients.add('rajansaravana007@gmail.com');
  message.subject = 'This is subject';
  message.text = 'This is text';

  try {
    final sendReport = await send(message, smptServer);
    print('Message is sent $sendReport');
  } on MailerException catch (e) {
    print(e);
  }
}
