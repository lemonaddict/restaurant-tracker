import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restrack/config/config.dart';

class ReservationService {
  Future<void> createReservation(String date, String time, String table, List<String> menus) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/reservations'),
      headers: {'Content-Type': 'application/json'},
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