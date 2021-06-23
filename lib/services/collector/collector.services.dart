import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:devbynasirulahmed/models/api_response.dart';
import 'package:devbynasirulahmed/models/collector.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse<Collector>> getCollector() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  int? id = prefs.getInt('collectorId');

  Uri url = Uri.parse("$janaklyan/api/collector/get-collector-by-id");

  try {
    print(token);
    print(id);
    var res = await http.post(
      url,
      body: jsonEncode(<String, dynamic>{"id": id}),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token"
      },
    );

    if (200 == res.statusCode) {
      var jsonData = jsonDecode(res.body);

      print(jsonData[0].toString());

      await prefs.setString("email", jsonData[0]['email']);

      Collector collector = Collector.fromJson(jsonData[0]);

      return ApiResponse<Collector>(
        data: collector,
      );
    } else {
      return ApiResponse<Collector>(
        err: true,
        errorMsg: 'An Error occured',
      );
    }
  } catch (e) {
    return ApiResponse<Collector>(
      err: true,
      errorMsg: 'An Error occured',
    );
  }
}
