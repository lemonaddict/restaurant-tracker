import 'package:flutter/material.dart';
import 'package:restrack/services/auth_service.dart';
import 'package:restrack/pages/choose_table_page.dart';
import 'package:restrack/services/reservation_service.dart';

// Halaman untuk memilih tanggal
// import 'package:restrack/services/database_service.dart';
// Halaman untuk memilih tanggal
class ChooseDatePage extends StatefulWidget {

   final AuthService authService;
  const ChooseDatePage({
    super.key,
    required this.authService,
  });

  @override
  _ChooseDatePageState createState() => _ChooseDatePageState();
}

class _ChooseDatePageState extends State<ChooseDatePage> {
  DateTime? selectedDate; // Untuk menyimpan tanggal yang dipilih

  // Fungsi untuk menampilkan dialog pemilihan tanggal
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update tanggal yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Tanggal',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Kolom untuk menampilkan tanggal yang dipilih
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tanggal yang Dipilih',
                hintText: 'Belum ada tanggal yang dipilih',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: TextEditingController(
                text: selectedDate != null
                    ? '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}'
                    : '',
              ),
              onTap: () => _selectDate(context), // Memanggil fungsi pemilihan tanggal
            ),
            const SizedBox(height: 20),
            // Tombol untuk memilih tanggal
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange,
              ),
              child: const Text('Pilih Tanggal'),
            ),
            const SizedBox(height: 20),
            // Tombol untuk melanjutkan ke halaman pilih meja
            if (selectedDate != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseTablePage(authService: widget.authService),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange,
                ),
                child: const Text('Lanjutkan ke Pilih Meja'),
              ),
          ],
        ),
      ),
    );
  }
}
