import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_repayment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanRepaymentServices {
  Future<List<LoanRepayment>> getLoanRepayments(int loanAcNo) async {
    Uri url = Uri.parse("$janaklyan/api/admin/get-loan-repayment/$loanAcNo");

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');

    try {
      var res = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );
      if (200 == res.statusCode) {
        final parsed = jsonDecode(res.body).cast<Map<String, dynamic>>();
        print(parsed);
        return parsed
            .map<LoanRepayment>((json) => LoanRepayment.fromJson(json))
            .toList();
      }
      return List<LoanRepayment>.empty();
    } catch (e) {
      throw Exception(e);
    }
  }
}
