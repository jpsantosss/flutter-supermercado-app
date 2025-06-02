import 'package:flutter/material.dart';
import '../entidades/entidade.dart';
import '../controles/controle_cadastro.dart';
import 'pagina_entidade.dart';
import 'mensagem.dart';

mixin EstadoPaginaCadastro {
  late ControleCadastro controleCadastro;
  List<Entidade> entidades = [];

  List<Widget> criarConteudoItem(Entidade entidade);
  Widget criarPaginaEntidade(OperacaoCadastro operacaoCadastro, Entidade entidade);
  Entidade criarEntidade();
  Widget? criarGaveta() => null;

  void mostrarBarraMensagem(BuildContext context, String mensagem) {
    final snackBar = SnackBar(content: Text(mensagem));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void abrirPaginaEntidade(BuildContext context, OperacaoCadastro operacaoCadastro, Entidade entidade) async {
    bool confirmado = await Navigator.push(context,
      MaterialPageRoute(builder: (_) => criarPaginaEntidade(operacaoCadastro, entidade)),
    );

    if (confirmado) {
      int resultado;
      if (operacaoCadastro == OperacaoCadastro.inclusao) {
        resultado = await controleCadastro.incluir(entidade);
      } else {
        resultado = await controleCadastro.alterar(entidade);
      }

      if (resultado > 0) {
        controleCadastro.emitirLista();
        mostrarBarraMensagem(
          context,
          operacaoCadastro == OperacaoCadastro.inclusao
              ? 'Inclusão realizada com sucesso.'
              : 'Alteração realizada com sucesso.',
        );
      } else {
        mostrarBarraMensagem(context, 'Operação não foi realizada.');
      }
    }
  }

  Widget criarItemLista(BuildContext context, int index) {
    return Dismissible(
      key: Key(entidades[index].identificador.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await confirmar(context, 'Deseja realmente excluir?');
      },
      onDismissed: (_) async {
        int resultado = await controleCadastro.excluir(entidades[index].identificador);
        if (resultado > 0) {
          controleCadastro.emitirLista();
          mostrarBarraMensagem(context, 'Exclusão realizada com sucesso.');
        }
      },
      child: GestureDetector(
        onTap: () => abrirPaginaEntidade(
          context, OperacaoCadastro.edicao, entidades[index].criarCopia(),
        ),
        child: Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: criarConteudoItem(entidades[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget criarLista() {
    return StreamBuilder<List<Entidade>>(
      stream: controleCadastro.fluxo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          entidades = snapshot.data!;
          return ListView.builder(
            itemCount: entidades.length,
            itemBuilder: (context, index) => criarItemLista(context, index),
          );
        } else {
          return Center(
            child: Text('Nenhum item cadastrado.', style: TextStyle(fontSize: 18)),
          );
        }
      },
    );
  }

  Widget criarPagina(BuildContext context, String titulo) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      drawer: criarGaveta(),
      body: criarLista(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          abrirPaginaEntidade(context, OperacaoCadastro.inclusao, criarEntidade());
        },
      ),
    );
  }
}
