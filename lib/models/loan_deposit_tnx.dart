import 'dart:convert';

LoanDepositTnxModel loanDepositTnxModelFromJson(String str) =>
    LoanDepositTnxModel.fromJson(json.decode(str));

String loanDepositTnxModelToJson(LoanDepositTnxModel data) =>
    json.encode(data.toJson());

class LoanDepositTnxModel {
  LoanDepositTnxModel({
    this.id,
    this.collector,
    this.amount,
    this.createdAt,
    this.currentStatus,
  });

  int? id;
  int? collector;
  int? amount;
  String? createdAt;
  int? currentStatus;

  factory LoanDepositTnxModel.fromJson(Map<String, dynamic> json) =>
      LoanDepositTnxModel(
        id: json["id"],
        collector: json["collector"],
        amount: json["amount"],
        createdAt: json["createdAt"],
        currentStatus: json["currentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "collector": collector,
        "amount": amount,
        "createdAt": createdAt,
        "currentStatus": currentStatus,
      };
}
