import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Pasta Carbonara', 'category': 'Food', 'price': 45000, 'quantity': 0},
    {'name': 'Chicken Caesar Salad', 'category': 'Food', 'price': 38000, 'quantity': 0},
    {'name': 'Nasi Goreng Spesial', 'category': 'Food', 'price': 40000, 'quantity': 0},
    {'name': 'Cappuccino', 'category': 'Drink', 'price': 30000, 'quantity': 0},
    {'name': 'Lemon Tea', 'category': 'Drink', 'price': 25000, 'quantity': 0},
  ];

  int calculateTotalPrice() {
    return menuItems.fold(0, (total, item) {
      final price = item['price'] ?? 0;
      final quantity = item['quantity'] ?? 0;
      return total = ( price * quantity + total);
    });
  }

  void incrementQuantity(int index) {
    setState(() {
      menuItems[index]['quantity']++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (menuItems[index]['quantity'] > 0) {
        menuItems[index]['quantity']--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter item berdasarkan kategori
    final foodItems = menuItems.where((item) => item['category'] == 'Food').toList();
    final drinkItems = menuItems.where((item) => item['category'] == 'Drink').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Ordering'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Bagian Food
                  const Text(
                    'Food',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ...foodItems.map((item) {
                    final index = menuItems.indexOf(item);
                    return Card(
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Text('${item['category']} - Rp ${item['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => decrementQuantity(index),
                            ),
                            Text(item['quantity'].toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => incrementQuantity(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),

                  // Bagian Drink
                  const Text(
                    'Drink',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ...drinkItems.map((item) {
                    final index = menuItems.indexOf(item);
                    return Card(
                      child: ListTile(
                        title: Text(item['name']),
                        subtitle: Text('${item['category']} - Rp ${item['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => decrementQuantity(index),
                            ),
                            Text(item['quantity'].toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => incrementQuantity(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${calculateTotalPrice()}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    ));
