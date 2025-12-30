import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Tiket Pesanan',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                Icons.confirmation_number_outlined,
                size: 90,
                color: Colors.grey.shade400
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada tiket yang dipesan',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}