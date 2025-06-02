import 'package:flutter/material.dart';
import '../entidades/produto.dart';
import 'pagina_entidade.dart';
import 'mensagem.dart';

class PaginaProduto extends StatefulWidget with PaginaEntidade {
  PaginaProduto({required operacaoCadastro, required entidade}) {
    this.operacaoCadastro = operacaoCadastro;
    this.entidade = entidade;
  }

  @override
  State<PaginaProduto> createState() => _PaginaProdutoState();
}

class _PaginaProdutoState extends State<PaginaProduto> with EstadoPaginaEntidade {
  final _nomeController = TextEditingController();
  final _quantidadeController = TextEditingController();
  String _unidadeSelecionada = '';

  @override
  void initState() {
    super.initState();
    if (widget.operacaoCadastro == OperacaoCadastro.edicao) {
      Produto produto = widget.entidade as Produto;
      _nomeController.text = produto.nome;
      _quantidadeController.text = produto.quantidade.toString();
      _unidadeSelecionada = produto.unidade;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  @override
  List<Widget> criarConteudoFormulario(BuildContext context) {
    return [
      TextField(
        controller: _nomeController,
        decoration: InputDecoration(labelText: 'Nome do Produto'),
      ),
      TextField(
        controller: _quantidadeController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: 'Quantidade'),
      ),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: 'Unidade'),
        value: _unidadeSelecionada,
        items: unidadesProdutos.map((String unidade) {
          return DropdownMenuItem<String>(
            value: unidade,
            child: Text(unidade),
          );
        }).toList(),
        onChanged: (String? valor) {
          setState(() {
            _unidadeSelecionada = valor ?? '';
          });
        },
      ),
    ];
  }

  @override
  bool dadosCorretos(BuildContext context) {
    if (_nomeController.text.trim().isEmpty || _quantidadeController.text.trim().isEmpty) {
      informar(context, 'Todos os campos são obrigatórios.');
      return false;
    }

    final quantidade = double.tryParse(_quantidadeController.text);
    if (quantidade == null || quantidade <= 0) {
      informar(context, 'Informe uma quantidade válida.');
      return false;
    }

    return true;
  }

  @override
  void transferirDadosParaEntidade() {
    Produto produto = widget.entidade as Produto;
    produto.nome = _nomeController.text.trim();
    produto.quantidade = double.parse(_quantidadeController.text);
    produto.unidade = _unidadeSelecionada;
  }

  @override
  Widget build(BuildContext context) {
    return criarPagina(context, widget.operacaoCadastro, 'Produto');
  }
}
