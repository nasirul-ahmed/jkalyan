// // To parse this JSON data, do
// //
// //     final depositTnxModel = depositTnxModelFromJson(jsonString);

// import 'dart:convert';

// DepositTnxModel depositTnxModelFromJson(String str) =>
//     DepositTnxModel.fromJson(json.decode(str));

// String depositTnxModelToJson(DepositTnxModel data) =>
//     json.encode(data.toJson());

// class DepositTnxModel {
//   DepositTnxModel({
//     this.id,
//     this.collectorId,
//     this.amount,
//     this.createdAt,
//     this.currentStatus,
//   });

// int? id;
// int? collectorId;
// int? amount;
// String? createdAt;
// bool? currentStatus;

//   factory DepositTnxModel.fromJson(Map<String, dynamic> json) =>
//       DepositTnxModel(
//         id: json["id"],
//         collectorId: json["collectorId"],
//         amount: json["amount"],
//         createdAt: json["createdAt"],
//         currentStatus: json["currentStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "collectorId": collectorId,
//         "amount": amount,
//         "createdAt": createdAt,
//         "currentStatus": currentStatus,
//       };
// }

// To parse this JSON data, do
//
//     final depositTnxModel = depositTnxModelFromJson(jsonString);

import 'dart:convert';

DepositTnxModel depositTnxModelFromJson(String str) =>
    DepositTnxModel.fromJson(json.decode(str));

String depositTnxModelToJson(DepositTnxModel data) =>
    json.encode(data.toJson());

class DepositTnxModel {
  DepositTnxModel({
    this.id,
    this.collectorId,
    this.amount,
    this.createdAt,
    this.currentStatus,
  });

  int? id;
  int? collectorId;
  int? amount;
  String? createdAt;
  int? currentStatus;

  factory DepositTnxModel.fromJson(Map<String, dynamic> json) =>
      DepositTnxModel(
        id: json["id"],
        collectorId: json["collectorId"],
        amount: json["amount"],
        createdAt: json["createdAt"],
        currentStatus: json["currentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "collectorId": collectorId,
        "amount": amount,
        "createdAt": createdAt,
        "currentStatus": currentStatus,
      };
}
