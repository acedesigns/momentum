import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'http://127.0.0.1:8000/api/';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;

    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getWithToken(apiUrl) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fullUrl = _url + apiUrl;
    var token = localStorage.getString('token');

    return await http.get(Uri.parse(fullUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
  }

  postWithToken(data, apiUrl) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var fullUrl = _url + apiUrl;
    var token = pref.getString('token');

    return await http
        .post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token'
    });
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // Because Our Server is Laravel
        'X-Requested-With': 'XMLHttpRequest',
      };
}
