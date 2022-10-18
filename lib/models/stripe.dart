import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stripe_test/constant.dart';

class Payment {
  Future<String> createAcharge() async {
    List<Map<String, dynamic>> items = [
      {
        'price': 150 * 100,
        'quantity': 2,
        'name': 'test',
      },
      {
        'price': 35 * 100,
        'quantity': 1,
        'name': 'test2',
      },
      {
        'price': 55 * 100,
        'quantity': 3,
        'name': 'test3',
      },
    ];
    final url = Uri.parse('https://api.stripe.com/v1/checkout/sessions');

    Map<String, String> body = {
      'cancel_url': 'https://stripe-8741d.web.app/#payment-fail',
      'success_url': 'https://stripe-8741d.web.app/#payment-success',
      'mode': 'payment',
      'payment_method_types[0]': 'card',
    };
    for (int i = 0; i < items.length; i++) {
      body['line_items[$i][price_data][currency]'] = 'USD';
      body['line_items[$i][price_data][product_data][name]'] =
          items[i]['name'] as String;
      body['line_items[$i][price_data][unit_amount]'] =
          items[i]['price'].toString();
      body['line_items[$i][quantity]'] = items[i]['quantity'].toString();
    }
    final response = await http.post(url,
        headers: {'Authorization': 'Bearer $secretKey'}, body: body);

    print(response.body);

    final extractedData = json.decode(response.body);

    var returnUrl = extractedData['url'].toString();
    return returnUrl;
  }
}
