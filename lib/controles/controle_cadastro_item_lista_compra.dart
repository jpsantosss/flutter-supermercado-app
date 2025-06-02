import '../banco_dados/acesso_banco_dados.dart';
import '../banco_dados/dicionario_dados.dart';
import '../entidades/item_lista_compra.dart';
import '../entidades/entidade.dart';
import '../entidades/produto.dart';
import 'controle_cadastro.dart';
import 'controle_cadastro_produto.dart';

class ControleCadastroItemListaCompra extends ControleCadastro {
  final ControleCadastroProduto controleProduto = ControleCadastroProduto();

  ControleCadastroItemListaCompra()
      : super(DicionarioDados.tabelaItemListaCompra, DicionarioDados.idListaCompra);

  @override
  Future<Entidade> criarEntidade(Map<String, dynamic> mapa) async {
    ItemListaCompra item = ItemListaCompra.criarDeMapa(mapa);
    Produto produto = await controleProduto.selecionar(item.idProduto) as Produto;
    item.produto = produto;
    return item;
  }

  Future<List<Entidade>> selecionarDaListaCompra(int idListaCompra) async {
    final db = await AcessoBancoDados().bancoDados;
    var resultado = await db.query(
      tabela,
      where: '${DicionarioDados.idListaCompra} = ?',
      whereArgs: [idListaCompra],
    );
    return await criarListaEntidades(resultado);
  }

  Future<int> excluirDaListaCompra(int idListaCompra) async {
    final db = await AcessoBancoDados().bancoDados;
    return await db.delete(
      tabela,
      where: '${DicionarioDados.idListaCompra} = ?',
      whereArgs: [idListaCompra],
    );
  }
}
