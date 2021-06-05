// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

LoanCustomer customerFromJson(String str) =>
    LoanCustomer.fromJson(json.decode(str));

String customerToJson(LoanCustomer data) => json.encode(data.toJson());

class LoanCustomer {
  LoanCustomer({
    this.id,
    this.accountNumber,
    this.name,
    this.fatherName,
    this.address,
    this.pinCode,
    this.occupation,
    this.nomineeName,
    this.nomineeAddress,
    this.nomineePhone,
    this.relation,
    this.nomineeFatherName,
    this.rateOfInterest,
    this.totalInstallments,
    this.installmentAmount,
    this.maturityDate,
    this.payableAmount,
    this.totalInterestAmount,
    this.agentUid,
    this.createdAt,
    this.phone,
    this.dob,
    this.accountType,
    this.profile,
    this.signature,
    this.loanAmount,
    this.profit,
  });

  int? id;
  int? accountNumber;
  String? name;
  String? fatherName;
  String? address;
  int? pinCode;
  String? occupation;
  String? nomineeName;
  String? nomineeAddress;
  int? nomineePhone;
  String? relation;
  String? nomineeFatherName;
  int? rateOfInterest;
  int? totalInstallments;
  int? installmentAmount;
  String? maturityDate;
  int? payableAmount;
  int? totalInterestAmount;

  int? agentUid;
  String? createdAt;
  int? phone;
  String? dob;
  String? accountType;
  String? profile;
  String? signature;
  int? loanAmount;
  double? profit;

  factory LoanCustomer.fromJson(Map<String, dynamic> json) => LoanCustomer(
        id: json["id"],
        accountNumber: json["accountNumber"],
        name: json["name"],
        fatherName: json["fatherName"],
        address: json["address"],
        pinCode: json["pinCode"],
        occupation: json["occupation"],
        nomineeName: json["nomineeName"],
        nomineeAddress: json["nomineeAddress"],
        nomineePhone: json["nomineePhone"],
        relation: json["relation"],
        nomineeFatherName: json["nomineeFatherName"],
        rateOfInterest: json["rateOfInterest"],
        totalInstallments: json["totalInstallments"],
        installmentAmount: json["installmentAmount"],
        maturityDate: json["maturityDate"],
        payableAmount: json["payableAmount"],
        totalInterestAmount: json["totalInterestAmount"],
        agentUid: json["agentUid"],
        createdAt: json["createdAt"],
        phone: json["phone"],
        dob: json["dob"],
        accountType: json["accountType"],
        profile: json["profile"],
        signature: json["signature"],
        loanAmount: json["loanAmount"],
        profit: json["profit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountNumber": accountNumber,
        "name": name,
        "fatherName": fatherName,
        "address": address,
        "pinCode": pinCode,
        "occupation": occupation,
        "nomineeName": nomineeName,
        "nomineeAddress": nomineeAddress,
        "nomineePhone": nomineePhone,
        "relation": relation,
        "nomineeFatherName": nomineeFatherName,
        "rateOfInterest": rateOfInterest,
        "totalInstallments": totalInstallments,
        "installmentAmount": installmentAmount,
        "maturityDate": maturityDate,
        "payableAmount": payableAmount,
        "totalInterestAmount": totalInterestAmount,
        "agentUid": agentUid,
        "createdAt": createdAt,
        "phone": phone,
        "dob": dob,
        "accountType": accountType,
        "profile": profile,
        "signature": signature,
        "loanAmount": loanAmount,
        "profit": profit,
      };
}
