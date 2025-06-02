import '../banco_dados/dicionario_dados.dart';
import '../banco_dados/acesso_banco_dados.dart';
import 'controle_cadastro.dart';
import '../entidades/entidade.dart';
import '../entidades/produto.dart';
import '../entidades/tipo_produto.dart';
import 'controle_cadastro_tipo_produto.dart';

class ControleCadastroProduto extends ControleCadastro {
  final ControleCadastroTipoProduto controleTipo = ControleCadastroTipoProduto();

  ControleCadastroProduto()
      : super(DicionarioDados.tabelaProduto, DicionarioDados.idProduto);

  @override
  Future<Entidade> criarEntidade(Map<String, dynamic> mapa) async {
    Produto produto = Produto.criarDeMapa(mapa);
    TipoProduto tipo = await controleTipo.selecionar(produto.idTipoProduto) as TipoProduto;
    produto.tipoProduto = tipo;
    return produto;
  }

  Future<List<Entidade>> selecionarPorTipo(int idTipoProduto) async {
    final db = await AcessoBancoDados().bancoDados;
    List<Map<String, dynamic>> resultado;

    if (idTipoProduto > 0) {
      resultado = await db.query(
        tabela,
        where: '${DicionarioDados.idTipoProduto} = ?',
        whereArgs: [idTipoProduto],
      );
    } else {
      resultado = await db.query(tabela);
    }

    return await criarListaEntidades(resultado);
  }
}
