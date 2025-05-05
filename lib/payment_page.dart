import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedMethod = 'PIX';

  final List<String> paymentMethods = [
    'Pix',
    'Dinheiro',
    'Cartão de Crédito/Débito',
    'Vale Alimentação/Refeição'
  ];

  void _finalizePayment() {
    if (_selectedMethod != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pagamento finalizado com $_selectedMethod!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formas de Pagamento")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Selecione uma forma de pagamento:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...paymentMethods.map((method) => RadioListTile<String>(
              title: Text(method),
              value: method,
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value;
                });
              },
            )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _finalizePayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 110, vertical: 12),
              ),
              child: Text('Finalizar Pagamento'),
            ),
          ],
        ),
      ),
    );
  }
}