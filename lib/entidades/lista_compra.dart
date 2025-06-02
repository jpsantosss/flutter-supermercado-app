import '../banco_dados/dicionario_dados.dart';
import 'entidade.dart';
import 'item_lista_compra.dart';
import 'produto.dart';

class ListaCompra extends Entidade {
  static const primeiroNumeroItem = 1;
  int _numeroItem = primeiroNumeroItem;

  String nome = '';
  final List<ItemListaCompra> _itens = [];

  ListaCompra({int idCompra = 0, this.nome = ''}) : super(idCompra);

  ListaCompra.criarDeMapa(Map<String, dynamic> mapa)
      : super.criarDeMapa(mapa) {
    identificador = mapa[DicionarioDados.idListaCompra];
    nome = mapa[DicionarioDados.nome];
  }

  @override
  Entidade criarEntidade(Map<String, dynamic> mapa) {
    ListaCompra nova = ListaCompra.criarDeMapa(mapa);
    for (var item in _itens) {
      nova.incluirItem(item.criarCopia() as ItemListaCompra);
    }
    return nova;
  }

  bool temItens() => _itens.isNotEmpty;

  List<ItemListaCompra> get itens => _itens;

  void excluirItens() {
    _itens.clear();
    _numeroItem = primeiroNumeroItem;
  }

  void incluirItem(ItemListaCompra item) {
    _itens.add(item);
    if (item.numeroItem >= _numeroItem) {
      _numeroItem = item.numeroItem + 1;
    }
  }

  void incluirProduto(Produto produto, double quantidade) {
    var item = ItemListaCompra(
      numeroItem: _numeroItem,
      produto: produto,
      quantidade: quantidade,
      selecionado: false,
    );
    _itens.add(item);
    _numeroItem++;
  }

  void excluirItem(int numeroItem) {
    _itens.removeWhere((item) => item.numeroItem == numeroItem);
  }

  List<ItemListaCompra> retornarItensPorTipo(int idTipoProduto) {
    return _itens
        .where((item) =>
            idTipoProduto == 0 || item.produto.idTipoProduto == idTipoProduto)
        .toList();
  }

  List<Produto> retornarProdutosPorTipo(int idTipoProduto) {
    return _itens
        .where((item) =>
            idTipoProduto == 0 || item.produto.idTipoProduto == idTipoProduto)
        .map((item) => item.produto)
        .toList();
  }

  @override
  Map<String, dynamic> converterParaMapa() {
    final mapa = {DicionarioDados.nome: nome};
    if (identificador > 0) {
      mapa[DicionarioDados.idListaCompra] = identificador;
    }
    return mapa;
  }
}
