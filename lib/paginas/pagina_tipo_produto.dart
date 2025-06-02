import 'package:flutter/material.dart';
import '../entidades/tipo_produto.dart';
import 'pagina_entidade.dart';
import 'mensagem.dart';

class PaginaTipoProduto extends StatefulWidget with PaginaEntidade {
  PaginaTipoProduto({required operacaoCadastro, required entidade}) {
    this.operacaoCadastro = operacaoCadastro;
    this.entidade = entidade;
  }

  @override
  State<PaginaTipoProduto> createState() => _PaginaTipoProdutoState();
}

class _PaginaTipoProdutoState extends State<PaginaTipoProduto> with EstadoPaginaEntidade {
  final _controladorNome = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.operacaoCadastro == OperacaoCadastro.edicao) {
      _controladorNome.text = (widget.entidade as TipoProduto).nome;
    }
  }

  @override
  void dispose() {
    _controladorNome.dispose();
    super.dispose();
  }

  @override
  List<Widget> criarConteudoFormulario(BuildContext context) {
    return [
      TextField(
        controller: _controladorNome,
        decoration: InputDecoration(labelText: 'Nome'),
      ),
    ];
  }

  @override
  bool dadosCorretos(BuildContext context) {
    TipoProduto tipoProduto = widget.entidade as TipoProduto;
    if (_controladorNome.text.trim().isEmpty) {
      informar(context, 'É necessário informar o nome.');
      return false;
    }
    return true;
  }

  @override
  void transferirDadosParaEntidade() {
    TipoProduto tipoProduto = widget.entidade as TipoProduto;
    tipoProduto.nome = _controladorNome.text;
  }

  @override
  Widget build(BuildContext context) {
    return criarPagina(context, widget.operacaoCadastro, 'Tipo de Produto');
  }
}
