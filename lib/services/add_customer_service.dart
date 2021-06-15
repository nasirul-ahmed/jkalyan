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
    String age,
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
    String accountType,
    int nomineeAge,
    int depositAmount) async {
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
      'age': int.parse(age),
      'nomineeName': nomineeName,
      'nomineeAddress': nomineeAddress,
      'nomineePhone': nomineePhone,
      'relation': relation,
      'nomineeFatherName': nomineeFatherName,
      'nomineeAge': nomineeAge,
      'createdAt': createdAt,
      //'rateOfInterest': rateOfInterest,
      'totalInstallments': totalInstallments,
      'installmentAmount': installmentAmount,
      'totalPrincipalAmount': totalPrincipalAmount,
      'totalInterestAmount': totalInterestAmount,
      'totalMaturityAmount': totalMaturityAmount,
      'maturityDate': maturityDate,
      'agentUid': _prefs.getInt("collectorId"),
      "accountType": accountType,
      //'totalCollection': depositAmount
    }),
  );

  if (response.statusCode == 200) {
    print('success added' + response.body.toString());
    var jsonData = jsonDecode(response.body);
    return Customer.fromJson(jsonData);
  } else {
    print(response.statusCode);
    throw Exception('wrong');
  }
}
