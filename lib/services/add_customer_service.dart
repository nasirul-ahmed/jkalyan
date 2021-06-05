import 'dart:convert';

import 'package:devbynasirulahmed/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Customer> createCustomer(
  int accountNumber,
  String name,
  String fatherName,
  String address,
  int pinCode,
  int phone,
  String occupation,
  String dob,
  String nomineeName,
  String nomineeAddress,
  int nomineePhone,
  String relation,
  String nomineeFatherName,
  String createdAt,
  int rateOfInterest,
  int totalInstallments,
  int installmentAmount,
  int totalPrincipalAmount,
  double totalInterestAmount,
  double totalMaturityAmount,
  String maturityDate,
  String agentUid,
  String accountType,
) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String uri = 'https://sanchay-new.herokuapp.com/api/agents/customer/create';
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
      'totalPrincipalAmount': totalPrincipalAmount,
      'totalInterestAmount': totalInterestAmount,
      'totalMaturityAmount': totalMaturityAmount,
      'maturityDate': maturityDate,
      'agentUid': _prefs.getInt("collectorId"),
      "accountType": accountType,
    }),
  );

  if (response.statusCode >= 200 && response.statusCode < 404) {
    print('success added' + response.body.toString());

    return Customer.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('wrong');
  }
}
