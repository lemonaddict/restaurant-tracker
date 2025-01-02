// lib/services/user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'auth_service.dart';

class UserService {
  final String baseUrl;
  final AuthService authService;

  UserService({required this.baseUrl, required this.authService});

  Future<User> getCurrentUser() async {
    try {
      final headers = await authService.getAuthHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}