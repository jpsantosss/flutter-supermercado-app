import 'package:flutter/material.dart';
import '../controles/controle_cadastro_tipo_produto.dart';
import '../entidades/tipo_produto.dart';
import '../entidades/entidade.dart';
import 'pagina_cadastro.dart';
import 'pagina_tipo_produto.dart';
import 'pagina_entidade.dart';

class PaginaCadastroTipoProduto extends StatefulWidget {
  @override
  State<PaginaCadastroTipoProduto> createState() =>
      _PaginaCadastroTipoProdutoState();
}

class _PaginaCadastroTipoProdutoState extends State<PaginaCadastroTipoProduto>
    with EstadoPaginaCadastro {
  @override
  void initState() {
    super.initState();
    controleCadastro = ControleCadastroTipoProduto();
    controleCadastro.emitirLista();
  }

  @override
  Widget build(BuildContext context) {
    return criarPagina(context, 'Tipos de Produtos');
  }

  @override
  Widget criarPaginaEntidade(
      OperacaoCadastro operacaoCadastro, Entidade entidade) {
    return PaginaTipoProduto(
      operacaoCadastro: operacaoCadastro,
      entidade: entidade,
    );
  }

  @override
  Entidade criarEntidade() {
    return TipoProduto(nome: '');
  }

  @override
  List<Widget> criarConteudoItem(Entidade entidade) {
    return [
      SizedBox(height: 10),
      Text((entidade as TipoProduto).nome),
      SizedBox(height: 10),
    ];
  }
}
