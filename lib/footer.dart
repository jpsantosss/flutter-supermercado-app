import 'package:flutter/material.dart';

Widget buildFooter() {
  return Container(
    width: double.infinity,
    color: Colors.green[700],
    padding: const EdgeInsets.all(12),
    child: const Text(
      'Supermercado Ccomp © 2025 Todos os direitos reservados',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 11,
      ),
      textAlign: TextAlign.center,
    ),
  );
}