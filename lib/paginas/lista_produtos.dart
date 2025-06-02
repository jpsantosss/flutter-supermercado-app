import 'package:flutter/material.dart';
import '../entidades/produto.dart';

class ListaProdutos extends StatelessWidget {
  final List<Produto> produtos;
  final Function(Produto) aoSelecionar;

  ListaProdutos({required this.produtos, required this.aoSelecionar});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (_, index) {
        final produto = produtos[index];
        return ListTile(
          title: Text(produto.nome),
          subtitle: Text('${produto.quantidade} ${produto.unidade}'),
          onTap: () => aoSelecionar(produto),
        );
      },
    );
  }
}
