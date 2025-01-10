import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  final List<Map<String, String>> teamMembers = const [
    {
      "name": " Daniel Ebenezer Budiharto",
      "role": "Back-End Developer",
      "image": "assets/Foto-budi.jpg",
    },
    {
      "name": "Stephen Wijaya Utama ",
      "role": "Front-End Developer",
      "image": "assets/Foto-stephen.jpg",
    },
    {
      "name": "Muhammad Rafie Kurnia",
      "role": "Front-end Developer",
      "image": "assets/Foto-rafie.jpg",
    },
    {
      "name": "Salomo Agung Adrianto Rehmina Hutapea",
      "role": "System  Analyst",
      "image": "assets/Foto-adri.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Center(  // Gunakan Center untuk menempatkan seluruh Column di tengah layar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menempatkan elemen-elemen di tengah secara vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // Menempatkan elemen-elemen di tengah secara horizontal
            children: [
              const Text(
                "Meet Our Team",
                style: TextStyle(
                  fontSize: 36, // Ukuran font diperbesar
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0), // Mengurangi jarak antara judul dan foto
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Menempatkan foto-foto di tengah
                    children: teamMembers.map((member) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Menyesuaikan jarak antar elemen
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 90, // Ukuran foto diperbesar
                              backgroundImage: AssetImage(member["image"]!),
                            ),
                            const SizedBox(height: 8.0), // Mengurangi jarak antara foto dan nama
                            Text(
                              member["name"]!,
                              style: const TextStyle(
                                fontSize: 20, // Ukuran font diperbesar
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0), // Mengurangi jarak antara nama dan jabatan
                            Text(
                              member["role"]!,
                              style: const TextStyle(
                                fontSize: 18, // Ukuran font diperbesar
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 