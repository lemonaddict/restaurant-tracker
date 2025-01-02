import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ReservationService {
  final String baseUrl;
  final AuthService authService;

  ReservationService({required this.baseUrl, required this.authService});

  Future<List<dynamic>> getMyReservations() async {
    final headers = await authService.getAuthHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/reservations/my-reservations'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to get reservations');
  }

  Future<dynamic> createReservation(DateTime dateTime, int tableId, List<int> menuIds) async {
    final headers = await authService.getAuthHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/reservations'),
      headers: headers,
      body: json.encode({
        'date_time': dateTime.toUtc().toIso8601String(),
        'table_id': tableId,
        'menu_ids': menuIds,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    }
    throw Exception('Failed to create reservation');
  }

  Future<void> updateStatus(int reservationId, String status) async {
    final headers = await authService.getAuthHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/reservations/$reservationId/status'),
      headers: headers,
      body: json.encode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update status');
    }
  }

  Future<void> updateDeposit(int reservationId, bool deposited) async {
    final headers = await authService.getAuthHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/reservations/$reservationId/deposit'),
      headers: headers,
      body: json.encode({'deposited': deposited}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update deposit');
    }
  }

  Future<void> cancelByUser(int reservationId) async {
    final headers = await authService.getAuthHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/reservations/$reservationId/cancel-by-user'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel reservation');
    }
  }
}