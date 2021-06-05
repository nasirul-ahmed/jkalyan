import 'dart:convert';

import 'package:devbynasirulahmed/models/transactions.dart';

List<TransactionsModel> parseTransactions(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<TransactionsModel>((json) => TransactionsModel.fromJson(json))
      .toList();
}
