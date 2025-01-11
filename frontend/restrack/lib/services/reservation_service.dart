import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restrack/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationService {
  Future<void> createReservation(String date, String time, String table, List<Map<String, dynamic>> menus) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/reservations/create-new-reservation'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'date': date,
        'time': time,
        'table': table,
        'menus': menus,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create reservation');
    }
  }
}