import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../banco_dados/acesso_banco_dados.dart';
import '../entidades/entidade.dart';

abstract class ControleCadastro {
  final String tabela;
  final String campoIdentificador;
  late List<Entidade> entidades;

  ControleCadastro(this.tabela, this.campoIdentificador);

  Future<int> incluir(Entidade entidade) async {
    final db = await AcessoBancoDados().bancoDados;
    return await db.insert(tabela, entidade.converterParaMapa());
  }

  Future<int> alterar(Entidade entidade) async {
    final db = await AcessoBancoDados().bancoDados;
    return await db.update(
      tabela,
      entidade.converterParaMapa(),
      where: '$campoIdentificador = ?',
      whereArgs: [entidade.identificador],
    );
  }

  Future<int> excluir(int identificador) async {
    final db = await AcessoBancoDados().bancoDados;
    return await db.delete(
      tabela,
      where: '$campoIdentificador = ?',
      whereArgs: [identificador],
    );
  }

  Future<Entidade?> selecionar(int identificador) async {
    final db = await AcessoBancoDados().bancoDados;
    List<Map<String, dynamic>> registros = await db.query(
      tabela,
      where: '$campoIdentificador = ?',
      whereArgs: [identificador],
    );
    if (registros.isNotEmpty) {
      return await criarEntidade(registros.first);
    }
    return null;
  }

  Future<List<Entidade>> selecionarTodos() async {
    final db = await AcessoBancoDados().bancoDados;
    var resultado = await db.query(tabela);
    return await criarListaEntidades(resultado);
  }

  Future<List<Entidade>> criarListaEntidades(List registros) async {
    List<Entidade> lista = [];
    for (var reg in registros) {
      lista.add(await criarEntidade(reg));
    }
    return lista;
  }

  Future<Entidade> criarEntidade(Map<String, dynamic> mapaEntidade);

  final StreamController<List<Entidade>> _controladorFluxoEntidades =
      StreamController<List<Entidade>>();

  Stream<List<Entidade>> get fluxo => _controladorFluxoEntidades.stream;

  Future<void> emitirLista() async {
    entidades = await selecionarTodos();
    _controladorFluxoEntidades.add(entidades);
  }

  void finalizar() {
    _controladorFluxoEntidades.close();
  }
}
