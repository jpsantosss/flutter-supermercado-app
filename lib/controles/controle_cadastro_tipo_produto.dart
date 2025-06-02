import '../banco_dados/dicionario_dados.dart';
import 'controle_cadastro.dart';
import '../entidades/entidade.dart';
import '../entidades/tipo_produto.dart';

class ControleCadastroTipoProduto extends ControleCadastro {
  ControleCadastroTipoProduto()
      : super(DicionarioDados.tabelaTipoProduto, DicionarioDados.idTipoProduto);

  @override
  Future<Entidade> criarEntidade(Map<String, dynamic> mapaEntidade) async {
    return TipoProduto.criarDeMapa(mapaEntidade);
  }
}
