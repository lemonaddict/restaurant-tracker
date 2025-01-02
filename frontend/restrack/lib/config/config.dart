// lib/config/config.dart
import 'package:flutter/material.dart';

// Theme Colors
const Color primaryColor = Color(0xFFFF9600);
const Color secondaryColor = Color(0xFFFF9600);
const Color accentColor = Color(0xFFFF9600);

// API Configuration
class ApiConfig {
  // For Android Emulator use 10.0.2.2 instead of localhost
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  // For iOS Simulator use:
  // static const String baseUrl = 'http://localhost:3000/api';
}