// lib/config/config.dart
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
// Theme Colors
const Color primaryColor = Color(0xFFFF9600);
const Color secondaryColor = Color(0xFFFF9600);
const Color accentColor = Color(0xFFFF9600);

// API Configuration
class ApiConfig {
  // For Android Emulator use 10.0.2.2 instead of localhost
  // static const String baseUrl = 'http://10.0.2.2:3000/api';
  // For iOS Simulator use:
  //static const String baseUrl = 'http://192.168.100.224:3000/api';
  static late String baseUrl;

  static void configureBaseUrl() {
    if (kIsWeb) {
      baseUrl = 'http://127.0.0.1:3000/api'; // Web
    } else if (Platform.isAndroid) {
      baseUrl = 'http://10.0.2.2:3000/api'; // Android Emulator
    } else if (Platform.isIOS) {
      baseUrl = 'http://127.0.0.1:3000/api'; // iOS Simulator
    } else {
      // Default to localhost for other platforms
      baseUrl = 'http://127.0.0.1:3000/api';
    }
  }
}
