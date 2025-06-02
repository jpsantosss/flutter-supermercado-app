import 'package:flutter/material.dart';
import '../entidades/produto.dart';
import '../controles/controle_cadastro_produto.dart';
import 'lista_produtos.dart';

class PaginaSelecaoProdutos extends StatefulWidget {
  @override
  _PaginaSelecaoProdutosState createState() => _PaginaSelecaoProdutosState();
}

class _PaginaSelecaoProdutosState extends State<PaginaSelecaoProdutos> {
  final controle = ControleCadastroProduto();
  List<Produto> _produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  void carregarProdutos() async {
    final resultado = await controle.selecionarTodos();
    setState(() {
      _produtos = resultado.cast<Produto>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um produto'),
        centerTitle: true,
      ),
      body: ListaProdutos(
        produtos: _produtos,
        aoSelecionar: (produto) {
          Navigator.pop(context, produto);
        },
      ),
    );
  }
}
