class TransactionModel {
  final int id;
  final String transactionDescription;
  final String transactionStatus;

  TransactionModel(
      {this.id, this.transactionDescription, this.transactionStatus});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionDescription': transactionDescription,
      'transactionStatus': transactionStatus,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> json) =>
      new TransactionModel(
        id: json["id"],
        transactionDescription: json["transactionDescription"],
        transactionStatus: json["transactionStatus"],
      );
}
