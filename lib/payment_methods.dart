import 'package:flutter/material.dart';

class PaymentMethodsWidget extends StatefulWidget {
  @override
  _PaymentMethodsWidgetState createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  String? _selectedMethod = 'PIX';

  final List<String> paymentMethods = ['Pix','Dinheiro', 'Cartão de Crédito/Débito', 'Vale Alimentação/Refeição'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: paymentMethods.map((method) {
        return RadioListTile<String>(
          title: Text(method),
          value: method,
          groupValue: _selectedMethod,
          onChanged: (value) {
            setState(() {
              _selectedMethod = value;
            });
          },
        );
      }).toList(),
    );
  }
}
