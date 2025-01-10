import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restrack/config/config.dart';

class MenuService {
  Future<List<dynamic>> getMenus() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/menus'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load menus');
    }
  }
}