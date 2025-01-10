import 'package:flutter/material.dart';

class ReservationPage extends StatelessWidget {
  final List<Map<String, dynamic>> orderedItems;
  final double totalCost;
  final String day;
  final String date;
  final String tableNumber;

  ReservationPage({
    required this.orderedItems,
    required this.totalCost,
    required this.day,
    required this.date,
    required this.tableNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservation Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Day: $day'),
            Text('Date: $date'),
            Text('Table Number: $tableNumber'),
            Divider(),
            Text('Deposit: 15000 T Coin'),
            Divider(),
            Text(
              'Ordered Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...orderedItems.map((item) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${item['number']}. ${item['menu']}'),
                  Text('Qty: ${item['qty']}'),
                  Text('Total: \$${item['totalPrice'].toStringAsFixed(2)}'),
                ],
              );
            }).toList(),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                child: Text('Reserve'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Total Cost: \$${totalCost.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}