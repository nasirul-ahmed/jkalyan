import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LastLoanCustomerAddedService {
  Uri url = Uri.parse("$janaklyan/api/agents/loan-account");
  static const headers = {"Accept": "application/json"};
  Future<ApiResponse<LoanCustomer>> getLastCustomer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    //"Authorization": "Bearer $token"
    var res = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    try {
      if (200 == res.statusCode) {
        var customerMap = jsonDecode(res.body);
        LoanCustomer customer = LoanCustomer.fromJson(customerMap[0]);

        return ApiResponse<LoanCustomer>(
          data: customer,
        );
      } else {
        return ApiResponse<LoanCustomer>(
          err: true,
          errorMsg: 'An Error occured',
        );
      }
    } catch (e) {
      return ApiResponse<LoanCustomer>(
        err: true,
        errorMsg: 'An Error occured',
      );
    }
  }
}
