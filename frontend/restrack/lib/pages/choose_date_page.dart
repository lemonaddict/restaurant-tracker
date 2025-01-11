import 'package:flutter/material.dart';
import 'package:restrack/services/auth_service.dart';
import 'choose_table_page.dart';

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
  DateTime? selectedDateTime;

  void _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(), // Set firstDate to today
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

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
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

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pilih Tanggal dan Waktu',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Tanggal dan Waktu yang Dipilih',
                hintText: 'Belum ada tanggal dan waktu yang dipilih',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: TextEditingController(
                text: selectedDateTime != null
                    ? '${selectedDateTime!.day}-${selectedDateTime!.month}-${selectedDateTime!.year} ${selectedDateTime!.hour}:${selectedDateTime!.minute}'
                    : '',
              ),
              onTap: () => _selectDateTime(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDateTime(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange,
              ),
              child: const Text('Pilih Tanggal dan Waktu'),
            ),
            const SizedBox(height: 20),
            if (selectedDateTime != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseTablePage(
                        authService: widget.authService,
                        date: '${selectedDateTime!.day}-${selectedDateTime!.month}-${selectedDateTime!.year}',
                        time: '${selectedDateTime!.hour}:${selectedDateTime!.minute}',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange,
                ),
                child: const Text('Lanjutkan pilih meja'),
              ),
          ],
        ),
      ),
    );
  }
}