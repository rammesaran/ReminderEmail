import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'screens/transaction_page.dart';

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
    //initaldata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TransactionPage(),
    );
  }
}

void sendEmail() async {
  String username = 'rammesaran@gmail.com';
  String password = '******';

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
