enum TransactionStatus { pending, success, error }

class TransactionModel {
  int transactionid;
  String transactionDescription;

  TransactionStatus status;
  String datetime;

  TransactionModel(
      {this.datetime,
      this.status,
      this.transactionDescription,
      this.transactionid});

  Map<String, dynamic> toMap() {
    return {
      'id': transactionid,
      'description': transactionDescription,
      'transactionstatus': status,
      'dateAndTime': datetime,
    };
  }
}
