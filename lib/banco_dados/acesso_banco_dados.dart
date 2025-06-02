import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dicionario_dados.dart';

class AcessoBancoDados {
  static final AcessoBancoDados _instancia = AcessoBancoDados._criarInstancia();
  factory AcessoBancoDados() => _instancia;
  AcessoBancoDados._criarInstancia();

  late Database _bancoDados;

  Future<Database> _abrirBancoDados() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String caminho = '${diretorio.path}/${DicionarioDados.arquivoBancoDados}';

    var banco = await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarTabelas,
    );

    return banco;
  }

  Future<void> _criarTabelas(Database db, int versao) async {
    await db.execute('''
      CREATE TABLE ${DicionarioDados.tabelaTipoProduto} (
        ${DicionarioDados.idTipoProduto} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DicionarioDados.nome} TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DicionarioDados.tabelaProduto} (
        ${DicionarioDados.idProduto} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DicionarioDados.idTipoProduto} INTEGER NOT NULL,
        ${DicionarioDados.nome} TEXT NOT NULL,
        ${DicionarioDados.quantidade} REAL NOT NULL,
        ${DicionarioDados.unidade} TEXT,
        FOREIGN KEY (${DicionarioDados.idTipoProduto})
          REFERENCES ${DicionarioDados.tabelaTipoProduto}(${DicionarioDados.idTipoProduto})
          ON UPDATE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DicionarioDados.tabelaListaCompra} (
        ${DicionarioDados.idListaCompra} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DicionarioDados.nome} TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DicionarioDados.tabelaItemListaCompra} (
        ${DicionarioDados.idListaCompra} INTEGER NOT NULL,
        ${DicionarioDados.numeroItem} INTEGER NOT NULL,
        ${DicionarioDados.idProduto} INTEGER NOT NULL,
        ${DicionarioDados.quantidade} REAL NOT NULL,
        ${DicionarioDados.selecionado} TEXT NOT NULL,
        PRIMARY KEY (${DicionarioDados.idListaCompra}, ${DicionarioDados.numeroItem}),
        FOREIGN KEY (${DicionarioDados.idListaCompra})
          REFERENCES ${DicionarioDados.tabelaListaCompra}(${DicionarioDados.idListaCompra})
          ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (${DicionarioDados.idProduto})
          REFERENCES ${DicionarioDados.tabelaProduto}(${DicionarioDados.idProduto})
          ON DELETE CASCADE ON UPDATE CASCADE
      )
    ''');
  }

  Future<Database> get bancoDados async {
    _bancoDados = await _abrirBancoDados();
    return _bancoDados;
  }

  void fechar() {
    _bancoDados.close();
  }
}
