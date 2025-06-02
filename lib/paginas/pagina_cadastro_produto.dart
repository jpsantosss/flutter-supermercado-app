import 'package:flutter/material.dart';
import '../controles/controle_cadastro_produto.dart';
import '../entidades/produto.dart';
import '../entidades/entidade.dart';
import 'pagina_entidade.dart';
import 'pagina_cadastro.dart';
import 'pagina_produto.dart';

class PaginaCadastroProduto extends StatefulWidget {
  @override
  State<PaginaCadastroProduto> createState() => _PaginaCadastroProdutoState();
}

class _PaginaCadastroProdutoState extends State<PaginaCadastroProduto>
    with EstadoPaginaCadastro {
  @override
  void initState() {
    super.initState();
    controleCadastro = ControleCadastroProduto();
    controleCadastro.emitirLista();
  }

  @override
  Widget build(BuildContext context) {
    return criarPagina(context, 'Produtos');
  }

  @override
  Widget criarPaginaEntidade(OperacaoCadastro operacaoCadastro, Entidade entidade) {
    return PaginaProduto(
      operacaoCadastro: operacaoCadastro,
      entidade: entidade,
    );
  }

  @override
  Entidade criarEntidade() {
    return Produto(nome: '', quantidade: 0.0);
  }

  @override
  List<Widget> criarConteudoItem(Entidade entidade) {
    final produto = entidade as Produto;
    return [
      SizedBox(height: 10),
      Text(produto.nome, style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Quantidade: ${produto.quantidade} ${produto.unidade}'),
      SizedBox(height: 10),
    ];
  }
}
