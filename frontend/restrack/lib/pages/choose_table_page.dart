import 'package:flutter/material.dart';
import 'package:restrack/services/auth_service.dart';

class ChooseTablePage extends StatefulWidget {
  const ChooseTablePage({Key? key, required AuthService authService}) : super(key: key);

  @override
  _ChooseTablePageState createState() => _ChooseTablePageState();
}

class _ChooseTablePageState extends State<ChooseTablePage> {
  final List<bool> tableStatus = List.generate(10, (index) => false); // Status 10 meja

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Meja'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Jumlah kolom dalam grid
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: tableStatus.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  tableStatus[index] = !tableStatus[index]; // Toggle status meja
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: tableStatus[index] ? Colors.green : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: tableStatus[index] ? Colors.green : Colors.grey[400]!,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6.0,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.table_bar,
                      size: 60,
                      color: tableStatus[index] ? Colors.white : Colors.black54,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Meja ${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: tableStatus[index] ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      tableStatus[index] ? 'Dipilih' : 'Tersedia',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: tableStatus[index] ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
