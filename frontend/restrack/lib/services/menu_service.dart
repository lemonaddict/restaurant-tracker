import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restrack/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuService {
  Future<List<dynamic>> getMenus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/menus'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load menus');
    }
  }
}