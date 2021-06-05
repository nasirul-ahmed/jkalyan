class TransactionsModel {
  int? id;
  int? collector;
  int? amount;
  String? date;
  int? customer_account;

  TransactionsModel(
      {this.id, this.collector, this.amount, this.date, this.customer_account});

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
          id: json["id"],
          collector: json["collector"],
          amount: json["amount"],
          date: json["date"],
          customer_account: json["customer_account"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "collector": collector,
        "amount": amount,
        "date": date,
        "customer_account": customer_account
      };
}
