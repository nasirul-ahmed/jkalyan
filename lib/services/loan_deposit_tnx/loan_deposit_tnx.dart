import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_deposit_tnx.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<LoanDepositTnxModel>> getLoanDepositsTnx() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Uri url = Uri.parse(
      "$janaklyan/api/collector/loan-deposits/tnx/${prefs.getInt('collectorId')}");

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
          .map<LoanDepositTnxModel>(
              (json) => LoanDepositTnxModel.fromJson(json))
          .toList();
    } else {
      return List<LoanDepositTnxModel>.empty();
    }
  } catch (e) {
    return throw Exception();
  }
}
