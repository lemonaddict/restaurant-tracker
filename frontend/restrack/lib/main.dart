import 'package:flutter/material.dart';
import 'package:restrack/pages/team_page.dart';
import 'package:restrack/pages/menu_page.dart';
import 'package:restrack/pages/profile_page.dart';
import 'package:restrack/pages/landing_page.dart';
import 'package:restrack/pages/edit_profile_page.dart';
import 'package:restrack/pages/choose_date_page.dart';
import 'package:restrack/pages/choose_table_page.dart';
import 'package:restrack/services/auth_service.dart';
import 'package:restrack/config/config.dart';
import 'package:restrack/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiConfig.configureBaseUrl(); // Configure the base URL based on the platform
  final authService = AuthService();
  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restrack and Food Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/landing', // Rute awal ke LandingPage
      routes: {
        '/': (context) => LandingPage(authService: authService), // Halaman utama
        '/landing': (context) => LandingPage(authService: authService),
        '/profile': (context) => ProfilePage(authService: authService),
        // '/editProfile': (context) => EditProfilePage(),
        '/chooseDate': (context) => ChooseDatePage(authService: authService),
        '/chooseTable': (context) => ChooseTablePage(authService: authService),
        '/meetOurTeam': (context) => const MeetOurTeamPage(),
        '/menu': (context) => MenuPage(),
        '/home': (context) => HomePage(authService: authService),
      },
      // Tambahkan fallback jika rute tidak ditemukan
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => LandingPage(authService: authService),
      ),
    );
  }
}
