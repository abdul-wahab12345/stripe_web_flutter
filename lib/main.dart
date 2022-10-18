import 'package:flutter/material.dart';
import 'package:stripe_test/payment.dart';
import 'package:stripe_test/payment_fail.dart';
import 'package:stripe_test/payment_success.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (ctx) =>  PaymentScreen(),
        PaymentSuccessScreen.routeName: (ctx) =>  PaymentSuccessScreen(),
        PaymentFailScreen.routeName: (ctx) =>  PaymentFailScreen(),
      },
    );
  }
}
