import '../banco_dados/dicionario_dados.dart';
import 'entidade.dart';
import 'tipo_produto.dart';

const List<String> unidadesProdutos = ['', 'un', 'kg', 'g', 'mg', 'l', 'ml'];

class Produto extends Entidade {
  TipoProduto _tipoProduto = TipoProduto();
  String nome = '';
  double quantidade = 0.0;
  String unidade = '';
  int idTipoProduto = 0;

  Produto({int idProduto = 0, this.nome = '', this.quantidade = 0.0})
      : super(idProduto);

  Produto.criarDeMapa(Map<String, dynamic> mapa) : super.criarDeMapa(mapa) {
    identificador = mapa[DicionarioDados.idProduto];
    nome = mapa[DicionarioDados.nome];
    quantidade = mapa[DicionarioDados.quantidade];
    idTipoProduto = mapa[DicionarioDados.idTipoProduto];
    unidade = mapa[DicionarioDados.unidade];
  }

  @override
  Entidade criarEntidade(Map<String, dynamic> mapa) {
    return Produto.criarDeMapa(mapa);
  }

  TipoProduto get tipoProduto => _tipoProduto;

  set tipoProduto(TipoProduto tipoProduto) {
    _tipoProduto = tipoProduto;
    idTipoProduto = tipoProduto.identificador;
  }

  @override
  Map<String, dynamic> converterParaMapa() {
    final mapa = {
      DicionarioDados.idTipoProduto: idTipoProduto,
      DicionarioDados.nome: nome,
      DicionarioDados.quantidade: quantidade,
      DicionarioDados.unidade: unidade,
    };

    if (identificador > 0) {
      mapa[DicionarioDados.idProduto] = identificador;
    }

    return mapa;
  }
}
