// To parse this JSON data, do
//
//     final maturityModel = maturityModelFromJson(jsonString);

import 'dart:convert';

MaturityModel maturityModelFromJson(String str) =>
    MaturityModel.fromJson(json.decode(str));

String maturityModelToJson(MaturityModel data) => json.encode(data.toJson());

class MaturityModel {
  MaturityModel(
      {this.id,
      this.accountNumber,
      this.custName,
      this.maturityValue,
      this.closingDate,
      this.maturityAmount,
      this.maturityInterest,
      this.totalAmount,
      this.collectorId,
      this.isMatured,
      this.preMaturityCharge,
      this.isPreMaturity,
      this.address,
      this.fathersName,
      this.submitDate,
      this.processDate,
      this.openingDate,
      this.loss});

  int? id;
  int? accountNumber;
  String? custName;
  int? maturityValue;
  String? closingDate;
  int? maturityAmount;
  int? maturityInterest;
  int? totalAmount;
  int? collectorId;
  int? isMatured;
  int? preMaturityCharge;
  int? isPreMaturity;
  String? fathersName;
  String? address;
  String? submitDate;
  String? processDate;
  String? openingDate;
  int? loss;

  factory MaturityModel.fromJson(Map<String, dynamic> json) => MaturityModel(
        id: json["id"],
        accountNumber: json["accountNumber"],
        custName: json["custName"],
        maturityValue: json["maturityValue"],
        closingDate: json["closingDate"],
        maturityAmount: json["maturityAmount"],
        maturityInterest: json["maturityInterest"],
        totalAmount: json["totalAmount"],
        collectorId: json["collectorId"],
        isMatured: json["isMatured"],
        preMaturityCharge: json["preMaturityCharge"],
        isPreMaturity: json["isPreMaturity"],
        address: json["address"],
        fathersName: json["fathersName"],
        submitDate: json["submitDate"],
        processDate: json["processDate"],
        openingDate: json["openingDate"],
        loss: json["loss"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountNumber": accountNumber,
        "custName": custName,
        "maturityValue": maturityValue,
        "closingDate": closingDate,
        "maturityAmount": maturityAmount,
        "maturityInterest": maturityInterest,
        "totalAmount": totalAmount,
        "collectorId": collectorId,
        "isMatured": isMatured,
        "preMaturityCharge": preMaturityCharge,
        "isPreMaturity": isPreMaturity,
        "address": address,
        "fathersName": fathersName,
        "submitDate": submitDate,
        "processDate": processDate,
        "openingDate": openingDate,
        "loss": loss,
      };
}
