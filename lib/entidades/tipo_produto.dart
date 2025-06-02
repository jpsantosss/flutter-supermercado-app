import '../banco_dados/dicionario_dados.dart';
import 'entidade.dart';

class TipoProduto extends Entidade {
  String nome;

  TipoProduto({int idTipoProduto = 0, this.nome = ''}) : super(idTipoProduto);

  TipoProduto.criarDeMapa(Map<String, dynamic> mapa)
      : nome = mapa[DicionarioDados.nome] ?? '',
        super.criarDeMapa(mapa) {
    identificador = mapa[DicionarioDados.idTipoProduto];
  }

  @override
  Entidade criarEntidade(Map<String, dynamic> mapa) {
    return TipoProduto.criarDeMapa(mapa);
  }

  @override
  Map<String, dynamic> converterParaMapa() {
    final valores = {
      DicionarioDados.nome: nome,
    };

    if (identificador > 0) {
      valores[DicionarioDados.idTipoProduto] = identificador.toString();
    }

    return valores;
  }
}
