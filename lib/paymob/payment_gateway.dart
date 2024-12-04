import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentGateway extends StatefulWidget {
  final String paymentKey;
  const PaymentGateway({super.key, required this.paymentKey});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
  }

  void startPayment() async {
    if (_webViewController != null) {
      _webViewController!.loadUrl(
        urlRequest: URLRequest(
          url: WebUri(
            'https://accept.paymob.com/api/acceptance/iframes/884603?payment_token=${widget.paymentKey}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('about:blank'), // Start with a blank page
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          startPayment();
        },
        onLoadStop: (controller, url) {
          if (url != null && url.queryParameters.containsKey('success')) {
            // Check if payment was successful
            if (url.queryParameters['success'] == 'true') {
              print("Payment successful");
              Navigator.pop(context, true); // Return 'true' to indicate success
            } else {
              print("Payment failed");
              Navigator.pop(
                  context, false); // Return 'false' to indicate failure
            }
          }
        },
      ),
    );
  }
}
