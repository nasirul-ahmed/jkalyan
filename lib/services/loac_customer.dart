import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoanCustomerServices2 {
  int totalLoanCustomer=0;

  int getLoanCustomers() {

    return this.totalLoanCustomer;
  }



  void getLoanCustomer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        '$janaklyan/total/loan/customers/${_prefs.getInt('collectorId')}');

    // var body = jsonEncode({
    //   "collectorId": _prefs.getInt('collectorId'),
    // });

    try {
      var res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer ${_prefs.getString('token')}"
        },
      );
      if (200 == res.statusCode) {
        
        final parsed = jsonDecode(res.body);
        print(parsed);
        // totalLoanCustomer = parsed[]

        // this.totalLoanCustomer = parsed
        //     .map<LoanCustomer>((json) => LoanCustomer.fromJson(json))
        //     .toList();

        // return parsed
        //     .map<LoanCustomer>((json) => LoanCustomer.fromJson(json))
        //     .toList();
      }
    } catch (e) {
      throw e;
    }
  }
}
