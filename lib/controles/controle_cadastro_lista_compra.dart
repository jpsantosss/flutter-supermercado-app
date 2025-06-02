import 'controle_cadastro.dart';
import '../banco_dados/dicionario_dados.dart';
import '../entidades/entidade.dart';
import '../entidades/lista_compra.dart';
import '../entidades/item_lista_compra.dart';
import 'controle_cadastro_item_lista_compra.dart';

class ControleCadastroListaCompra extends ControleCadastro {
  final ControleCadastroItemListaCompra controleItens = ControleCadastroItemListaCompra();

  ControleCadastroListaCompra()
      : super(DicionarioDados.tabelaListaCompra, DicionarioDados.idListaCompra);

  @override
  Future<Entidade> criarEntidade(Map<String, dynamic> mapa) async {
    ListaCompra lista = ListaCompra.criarDeMapa(mapa);
    List<Entidade> itens = await controleItens.selecionarDaListaCompra(lista.identificador);
    for (var item in itens) {
      lista.incluirItem(item as ItemListaCompra);
    }
    return lista;
  }

  Future<int> processarItens(ListaCompra lista) async {
    int resultado = 0;
    await controleItens.excluirDaListaCompra(lista.identificador);
    for (var item in lista.itens) {
      item.identificador = lista.identificador;
      resultado = await controleItens.incluir(item);
    }
    return resultado;
  }

  @override
  Future<int> incluir(Entidade entidade) async {
    ListaCompra lista = entidade as ListaCompra;
    int resultado = await super.incluir(lista);
    if (resultado > 0) {
      lista.identificador = resultado;
      resultado = await processarItens(lista);
    }
    return resultado;
  }

  @override
  Future<int> alterar(Entidade entidade) async {
    ListaCompra lista = entidade as ListaCompra;
    int resultado = await super.alterar(lista);
    if (resultado > 0) {
      resultado = await processarItens(lista);
    }
    return resultado;
  }

  @override
  Future<int> excluir(int identificador) async {
    int resultado = await super.excluir(identificador);
    if (resultado > 0) {
      resultado = await controleItens.excluirDaListaCompra(identificador);
    }
    return resultado;
  }
}
