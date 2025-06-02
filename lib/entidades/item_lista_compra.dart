import 'produto.dart';
import 'entidade.dart';
import '../banco_dados/dicionario_dados.dart';

class ItemListaCompra extends Entidade {
  int numeroItem = 0;
  int idProduto = 0;
  Produto _produto = Produto();
  double quantidade = 0.0;
  bool selecionado = false;

  Produto get produto => _produto;

  set produto(Produto produto) {
    _produto = produto;
    idProduto = produto.identificador;
  }

  ItemListaCompra({
    int idListaCompra = 0,
    required this.numeroItem,
    required Produto produto,
    required this.quantidade,
    required this.selecionado,
  }) : super(idListaCompra) {
    this.produto = produto;
  }

  ItemListaCompra.criarDeMapa(Map<String, dynamic> mapa)
      : super.criarDeMapa(mapa) {
    identificador = mapa[DicionarioDados.idListaCompra];
    numeroItem = mapa[DicionarioDados.numeroItem];
    idProduto = mapa[DicionarioDados.idProduto];
    quantidade = mapa[DicionarioDados.quantidade];
    selecionado = mapa[DicionarioDados.selecionado] == 'S';
  }

  @override
  Entidade criarEntidade(Map<String, dynamic> mapa) {
    return ItemListaCompra.criarDeMapa(mapa);
  }

  @override
  Map<String, dynamic> converterParaMapa() {
    return {
      DicionarioDados.idListaCompra: identificador,
      DicionarioDados.numeroItem: numeroItem,
      DicionarioDados.idProduto: idProduto,
      DicionarioDados.quantidade: quantidade,
      DicionarioDados.selecionado: selecionado ? 'S' : 'N',
    };
  }
}
