import 'package:flutter/material.dart';
import 'package:restrack/services/auth_service.dart';
import 'reservation_page.dart';
import 'package:restrack/services/menu_service.dart';

class MenuPage extends StatefulWidget {
  final AuthService authService;
  final String date;
  final String time;
  final String tableNumber;

  const MenuPage({
    super.key,
    required this.authService,
    required this.date,
    required this.time,
    required this.tableNumber,
  });

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final MenuService menuService = MenuService();
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Pasta Carbonara', 'category': 'Food', 'price': 45000, 'quantity': 0},
    {'name': 'Chicken Caesar Salad', 'category': 'Food', 'price': 38000, 'quantity': 0},
    {'name': 'Nasi Goreng Spesial', 'category': 'Food', 'price': 40000, 'quantity': 0},
    {'name': 'Cappuccino', 'category': 'Beverage', 'price': 30000, 'quantity': 0},
    {'name': 'Lemon Tea', 'category': 'Beverage', 'price': 25000, 'quantity': 0},
  ];
  List<Map<String, dynamic>> orderedItems = [];

  // void initState() {
  //   super.initState();
  //   _loadMenus();
  // }

  // Future<void> _loadMenus() async {
  //   try {
  //     final fetchedMenus = await menuService.getMenus();
  //     setState(() {
  //       menuItems = fetchedMenus;
  //     });
  //   } catch (e) {
  //     print('Failed to load menus: $e');
  //   }
  // }

  void incrementQuantity(int index) {
    setState(() {
      menuItems[index]['quantity'] = (menuItems[index]['quantity'] ?? 0) + 1;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (menuItems[index]['quantity'] > 0) {
        menuItems[index]['quantity']--;
      }
    });
  }

  int calculateTotalPrice() {
    return menuItems.fold(0, (total, item) {
      final int price = item['price'] ?? 0;
      final int quantity = item['quantity'] ?? 0;
      return total + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodItems = menuItems.where((item) => item['category'] == 'Food').toList();
    final drinkItems = menuItems.where((item) => item['category'] == 'Beverage').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Ordering'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
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
                  const Text(
                    'Beverage',
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                orderedItems = menuItems
                    .where((item) => item['quantity'] > 0)
                    .map((item) => {
                          'menu': item['name'],
                          'qty': item['quantity'],
                          'totalPrice': item['price'] * item['quantity'],
                        })
                    .toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationPage(
                      orderedItems: orderedItems,
                      totalCost: calculateTotalPrice().toDouble(),
                      day: widget.date,
                      date: widget.date,
                      tableNumber: widget.tableNumber,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}