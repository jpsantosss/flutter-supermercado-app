import 'package:flutter/material.dart';
import '../controles/controle_cadastro_lista_compra.dart';
import '../entidades/lista_compra.dart';
import '../entidades/item_lista_compra.dart';
import '../entidades/produto.dart';
import '../entidades/entidade.dart';
import '../paginas/pagina_entidade.dart';
import '../paginas/mensagem.dart';
import 'pagina_selecao_produtos.dart';
import 'quantidade.dart';

class PaginaListaCompra extends StatefulWidget {
  final OperacaoCadastro operacaoCadastro;
  final ListaCompra listaCompra;

  PaginaListaCompra({
    required this.operacaoCadastro,
    required this.listaCompra,
  });

  @override
  _PaginaListaCompraState createState() => _PaginaListaCompraState();
}

class _PaginaListaCompraState extends State<PaginaListaCompra> with EstadoPaginaEntidade {
  final controle = ControleCadastroListaCompra();
  late ListaCompra _listaCompra;

  @override
  void initState() {
    super.initState();
    _listaCompra = widget.listaCompra;
  }

  Future<void> adicionarItem() async {
    final produto = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PaginaSelecaoProdutos()),
    );

    if (produto != null && produto is Produto) {
      final quantidade = await informarQuantidade(context);
      if (quantidade != null && quantidade > 0) {
        setState(() {
          _listaCompra.incluirProduto(produto, quantidade);
        });
      }
    }
  }

  Widget criarItem(ItemListaCompra item) {
    return CheckboxListTile(
      value: item.selecionado,
      onChanged: (valor) {
        setState(() {
          item.selecionado = valor ?? false;
        });
      },
      title: Text(item.produto.nome),
      subtitle: Text('${item.quantidade} ${item.produto.unidade}'),
      secondary: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            _listaCompra.excluirItem(item.numeroItem);
          });
        },
      ),
    );
  }

  @override
  List<Widget> criarConteudoFormulario(BuildContext context) {
    return [
      TextField(
        decoration: InputDecoration(labelText: 'Nome da Lista'),
        controller: TextEditingController(text: _listaCompra.nome),
        onChanged: (valor) => _listaCompra.nome = valor,
      ),
      SizedBox(height: 20),
      ElevatedButton.icon(
        icon: Icon(Icons.add),
        label: Text('Adicionar Produto'),
        onPressed: adicionarItem,
      ),
      SizedBox(height: 20),
      Text('Itens da Lista:', style: TextStyle(fontWeight: FontWeight.bold)),
      ..._listaCompra.itens.map(criarItem).toList(),
    ];
  }

  @override
  void transferirDadosParaEntidade() {
    widget.listaCompra.nome = _listaCompra.nome;
    widget.listaCompra.excluirItens();
    for (var item in _listaCompra.itens) {
      widget.listaCompra.incluirItem(item);
    }
  }

  @override
  bool dadosCorretos(BuildContext context) {
    if (_listaCompra.nome.trim().isEmpty) {
      informar(context, 'Informe o nome da lista.');
      return false;
    }
    if (!_listaCompra.temItens()) {
      informar(context, 'Adicione pelo menos um produto.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return criarPagina(context, widget.operacaoCadastro, 'Lista de Compras');
  }
}
