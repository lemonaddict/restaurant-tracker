import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final String baseUrl;
  static const String tokenKey = 'jwt_token';
  
  AuthService({required this.baseUrl});

  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        
        // Save token to secure storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(tokenKey, token);
        
        return token;
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Map<String, dynamic>> signup(String name, String email, String password, String telephoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'telephone_number': telephoneNumber,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        
        // Save token to secure storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(tokenKey, token);
        
        return {
          'token': token,
          'message': responseData['message'],
        };
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Failed to sign up');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Clear token from storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(tokenKey);

      // Call logout endpoint (optional since your backend just returns success)
      await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  // Helper method to get auth headers
  Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}