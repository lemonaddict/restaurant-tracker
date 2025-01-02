import 'package:flutter/material.dart';
import 'package:restrack/pages/landing_page.dart';
import 'package:restrack/services/auth_service.dart';
import 'package:restrack/config/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService(baseUrl: ApiConfig.baseUrl);
  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: LandingPage(authService: authService),
    );
  }
}