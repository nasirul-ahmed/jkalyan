import 'dart:convert';
import 'package:devbynasirulahmed/models/deposit_tnx.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<DepositTnxModel>> getDepositsTnx() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Uri url = Uri.parse(
      "https://sanchay-new.herokuapp.com/api/collector/deposit/tnx/${prefs.getInt('collectorId')}");

  try {
    var res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Accept": "*/*",
        "Authorization": "Bearer ${prefs.getString('token')}",
      },
    );

    if (200 == res.statusCode) {
      final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
      print(parsed);
      return parsed
          .map<DepositTnxModel>((json) => DepositTnxModel.fromJson(json))
          .toList();
    } else {
      return List<DepositTnxModel>.empty();
    }
  } catch (e) {
    return throw Exception();
  }
}
