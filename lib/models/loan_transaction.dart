// id int(11) AI PK
// collector int(11)
// amount int(11)
// createdAt date
// loanAccountNumber int(11)

class LoanTransactionsModel {
  LoanTransactionsModel(
      {this.id,
      this.collector,
      this.amount,
      this.createdAt,
      this.loanAccountNumber});
  int? id;
  int? collector;
  int? amount;
  String? createdAt;
  int? loanAccountNumber;

  factory LoanTransactionsModel.fromJson(Map<String, dynamic> json) =>
      LoanTransactionsModel(
          id: json["id"],
          collector: json["collector"],
          amount: json["amount"],
          createdAt: json["createdAt"],
          loanAccountNumber: json["loanAccountNumber"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "collector": collector,
        "amount": amount,
        "createdAt": createdAt,
        "loanAccountNumber": loanAccountNumber
      };
}
