import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class PaymobManager {
  Dio dio = Dio();

  Future<String> payWithPaymob(price) async {
    const String url = "https://accept.paymob.com/v1/intention/";

    // The payload for the API request
    Map<String, dynamic> payload = {
      "amount": price * 100,
      "currency": "EGP",
      "payment_methods": [4889352],
      "items": [],
      "billing_data": {
        "apartment": "dumy",
        "first_name": "ala",
        "last_name": "zain",
        "street": "dumy",
        "building": "dumy",
        "phone_number": "+92345xxxxxxxx",
        "city": "dumy",
        "country": "dumy",
        "email": "ali@gmail.com",
        "floor": "dumy",
        "state": "dumy"
      },
    };

    // Headers for the request
    Map<String, String> headers = {
      'Authorization':
          'Token egy_sk_test_d2d6a46a0b7c2e5bd18ce93f9713ba58334f0b4837b156eddd387a7c2e9e6a0c',
      'Content-Type': 'application/json'
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(payload),
      );

      // Print the response
      if (response.statusCode == 201 || response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['payment_keys'][0]['key'];
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
        return response.body;
      }
    } catch (e) {
      print("Exception: $e");
      return 'Error: Unable to create intention';
    }
  }
}
