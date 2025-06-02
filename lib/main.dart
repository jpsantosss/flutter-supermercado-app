import 'package:flutter/material.dart';
import 'paginas/pagina_principal.dart';

void main() {
  runApp(AppListaCompras());
}

class AppListaCompras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaginaPrincipal(),
    );
  }
}
