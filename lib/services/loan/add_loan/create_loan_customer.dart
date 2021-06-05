import 'dart:convert';

import 'package:devbynasirulahmed/models/loan_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

createLoanCustomer(
  accountNumber,
  name,
  fatherName,
  address,
  pinCode,
  phone,
  occupation,
  dob,
  nomineeName,
  nomineeAddress,
  nomineePhone,
  relation,
  nomineeFatherName,
  createdAt,
  rateOfInterest,
  totalInstallments,
  installmentAmount,
  payableAmount,
  totalInterestAmount,
  loanAmount,
  agentUid,
  accountType,
) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String uri =
      'https://sanchay-new.herokuapp.com/api/agents/loan/customer/create';
  final response = await http.post(
    Uri.parse(uri),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Authorization": "Bearer ${_prefs.getString('token')}"
    },
    body: jsonEncode(<String, dynamic>{
      'accountNumber': accountNumber,
      'name': name,
      'fatherName': fatherName,
      'address': address,
      'pinCode': pinCode,
      'phone': phone,
      'occupation': occupation,
      'dob': dob,
      'nomineeName': nomineeName,
      'nomineeAddress': nomineeAddress,
      'nomineePhone': nomineePhone,
      'relation': relation,
      'nomineeFatherName': nomineeFatherName,
      'createdAt': createdAt,
      'rateOfInterest': rateOfInterest,
      'totalInstallments': totalInstallments,
      'installmentAmount': installmentAmount,
      'payableAmount': payableAmount,
      'totalInterestAmount': totalInterestAmount,
      //'totalMaturityAmount': totalMaturityAmount,
      //'maturityDate': maturityDate,
      'agentUid': _prefs.getInt("collectorId"),
      "accountType": accountType,
    }),
  );

  if (response.statusCode >= 200 && response.statusCode < 404) {
    print('success added' + response.body.toString());

    return LoanCustomer.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('wrong');
  }
}
