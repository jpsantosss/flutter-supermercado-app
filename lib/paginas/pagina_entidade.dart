import 'package:flutter/material.dart';
import '../entidades/entidade.dart';

enum OperacaoCadastro { inclusao, edicao, selecao }

mixin PaginaEntidade {
  late OperacaoCadastro operacaoCadastro;
  late Entidade entidade;
}

mixin EstadoPaginaEntidade {
  List<Widget> criarConteudoFormulario(BuildContext context);
  void transferirDadosParaEntidade();
  bool dadosCorretos(BuildContext context);

  String prepararTitulo(OperacaoCadastro operacao, String titulo) {
    switch (operacao) {
      case OperacaoCadastro.inclusao:
        return 'Inclusão de $titulo';
      case OperacaoCadastro.edicao:
        return 'Edição de $titulo';
      case OperacaoCadastro.selecao:
        return 'Seleção de $titulo';
    }
  }

  Widget criarFormulario(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: criarConteudoFormulario(context) + [
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text('Salvar'),
                onPressed: () {
                  transferirDadosParaEntidade();
                  if (dadosCorretos(context)) {
                    Navigator.pop(context, true);
                  }
                },
              ),
              SizedBox(width: 30),
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.pop(context, false),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget criarPagina(BuildContext context, OperacaoCadastro operacao, String titulo) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prepararTitulo(operacao, titulo)),
        centerTitle: true,
      ),
      body: criarFormulario(context),
    );
  }
}
