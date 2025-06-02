import 'package:flutter/material.dart';

Future<double?> informarQuantidade(BuildContext context) async {
  final controller = TextEditingController();
  double? quantidade;

  return showDialog<double>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: Text('Informe a quantidade'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Quantidade',
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Confirmar'),
            onPressed: () {
              quantidade = double.tryParse(controller.text.replaceAll(',', '.'));
              Navigator.pop(context, quantidade);
            },
          ),
        ],
      );
    },
  );
}
