//services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restrack/config/config.dart';

class AuthService {
  static const String tokenKey = 'jwt_token';
  
  AuthService() {
    ApiConfig.configureBaseUrl(); // Ensure the base URL is configured
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      // Log the response for debugging
      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

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
      // Log the error for debugging
      print('Login error: $e');
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Map<String, dynamic>> signup(String name, String email, String password, String telephoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'telephone_number': telephoneNumber,
        }),
      );

      // Log the response for debugging
      print('Signup response status: ${response.statusCode}');
      print('Signup response body: ${response.body}');

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
      // Log the error for debugging
      print('Signup error: $e');
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
        Uri.parse('${ApiConfig.baseUrl}/auth/logout'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      // Log the error for debugging
      print('Logout error: $e');
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

  // Method to get current user profile
  Future<Map<String, dynamic>> getCurrentUser() async {
  try {
    final token = await getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // Construct URL - baseUrl already includes /api
    final url = '${ApiConfig.baseUrl}/users/me';
    print('Base URL: ${ApiConfig.baseUrl}');
    print('Making request to URL: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print('Response status code: ${response.statusCode}');
    print('Response headers: ${response.headers}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData;
    } else if (response.statusCode == 401) {
      // Clear token if unauthorized
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(tokenKey);
      throw Exception('Unauthorized: Please log in again');
    } else {
      throw Exception('Server returned status code: ${response.statusCode}. Body: ${response.body}');
    }
  } catch (e) {
    print('Detailed error in getCurrentUser: $e');
    if (e is FormatException) {
      print('Invalid JSON response received');
    }
    throw Exception('Failed to fetch profile: $e');
  }
}
}