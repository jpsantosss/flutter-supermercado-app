import 'package:flutter/material.dart';
import 'pagina_cadastro_tipo_produto.dart';
import 'pagina_cadastro_produto.dart';
import '../paginas/navegacao.dart';

class PaginaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavegacaoDrawer(
        itensMenu: [
          ItemMenu(
            titulo: 'Tipos de Produto',
            icone: Icons.category,
            destino: PaginaCadastroTipoProduto(),
          ),
          ItemMenu(
            titulo: 'Produtos',
            icone: Icons.shopping_bag,
            destino: PaginaCadastroProduto(),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Bem-vindo!',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
