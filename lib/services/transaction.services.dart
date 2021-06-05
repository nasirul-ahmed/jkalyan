import 'dart:convert';

import 'package:devbynasirulahmed/models/transactions.dart';
import 'package:devbynasirulahmed/services/transaction_list.service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<TransactionsModel>> getTnx() async {
  Uri url =
      Uri.parse("https://sanchay-new.herokuapp.com/api/collector/transactions");

  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? token = _prefs.getString('token');
  //"Authorization": "Bearer $token"

  var body = jsonEncode(<String, dynamic>{
    "id": _prefs.getString('collectorId'),
  });

  try {
    var res = await http.post(
      url,
      headers: {"Authorization": "Bearer $token"},
      body: body,
    );
    if (200 == res.statusCode) {
      return compute(parseTransactions, res.body);
    }
    return List<TransactionsModel>.empty();
  } catch (e) {
    throw Exception(e);
  }
}
