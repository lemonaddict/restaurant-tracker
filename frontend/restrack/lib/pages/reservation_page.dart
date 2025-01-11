import 'package:flutter/material.dart';
import 'package:restrack/services/reservation_service.dart';

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

  final ReservationService reservationService = ReservationService();

  Future<void> _createReservation(BuildContext context) async {
    try {
      // Convert orderedItems to a list of maps with menu_id and quantity
      final List<Map<String, dynamic>> formattedOrderedItems = orderedItems.map((item) {
        return {
          'menu_id': item['menu_id'],
          'quantity': item['qty'],
        };
      }).toList();

      await reservationService.createReservation(date, day, tableNumber, formattedOrderedItems);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reservation created successfully')),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create reservation: $e')),
      );
    }
  }

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
            Text('Deposit: 15000'),
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
                  Text('${item['menu']}'),
                  Text('Qty: ${item['qty']}'),
                  Text('Total: Rp ${item['totalPrice'].toInt()}'),
                ],
              );
            }).toList(),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () => _createReservation(context),
                child: Text('Reserve'),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Total Cost: Rp ${(totalCost + 15000).toInt()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}