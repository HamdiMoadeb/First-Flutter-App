import 'dart:convert';

import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'https://node-docapp.herokuapp.com/admin';
}

class ApiService {
  static Future<List<dynamic>> getEmployees() async {
    // RESPONSE JSON :
    // [{
    //   "id": "1",
    //   "employee_name": "",
    //   "employee_salary": "0",
    //   "employee_age": "0",
    //   "profile_image": ""
    // }]
    final response = await http.get('${URLS.BASE_URL}/all');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future<bool> addEmployee(body) async {
    // BODY
    // {
    //   "name": "test",
    //   "age": "23"
    // }

    final response = await http.post('${URLS.BASE_URL}/add',
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}
