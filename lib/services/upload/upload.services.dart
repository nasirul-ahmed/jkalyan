import 'dart:convert';
import 'package:devbynasirulahmed/constants/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

uploadPhoto(_profileData, _signatureData, accountNumber) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  var data = jsonEncode(<String, dynamic>{
    "profile": _profileData,
    "signature": _signatureData,
    "accountNumber": accountNumber,
    "id": _prefs.getInt('collectorId')
  });

  String uri = '$janaklyan/profile-upload';

  try {
    var res = await http.post(Uri.parse(uri),
        body: data,
        headers: {"Authorization": "Bearer ${_prefs.getString('token')}"});
    if (200 == res.statusCode) {
      print('photo uploaded');
    }
  } catch (e) {
    print(e);
  }
}
