enum TransactionStatus {
  success,
  pending,
  error,
}

class TransactionModel {
  final int id;
  final String transactionDescription;
  final String transactionStatus;
  final String dateTime;

  TransactionModel(
      {this.id,
      this.transactionDescription,
      this.transactionStatus,
      this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionDescription': transactionDescription,
      'transactionStatus': transactionStatus,
      'transactionTime': dateTime,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        transactionDescription: json["transactionDescription"],
        transactionStatus: json["transactionStatus"],
        dateTime: json["transactionTime"],
      );
}
