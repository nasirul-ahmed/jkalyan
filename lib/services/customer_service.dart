import 'dart:convert';

import 'package:devbynasirulahmed/models/customer.dart';

List<Customer> parseCustomer(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Customer>((json) => Customer.fromJson(json)).toList();
}
