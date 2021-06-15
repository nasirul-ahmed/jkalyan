import 'dart:convert';
import 'package:devbynasirulahmed/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Customer> getAcById(int createdId) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String uri =
      'https://sanchay-new.herokuapp.com/api/agents/customer/$createdId';
  final response = await http.get(
    Uri.parse(uri),
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Authorization": "Bearer ${_prefs.getString('token')}"
    },
  );

  if (response.statusCode == 200) {
    var jd = jsonDecode(response.body);
    print('$jd');
    //return jd['insertId'];
    return Customer.fromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('wrong');
  }
}
