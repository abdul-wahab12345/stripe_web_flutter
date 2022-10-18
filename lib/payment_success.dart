import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  static const routeName = 'payment-success';


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Payment Completed',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
