import 'package:flutter/material.dart';
import 'product.dart';

class SearchPage extends StatefulWidget {
  final List<Product> products;
  final void Function(Product) onEdit;
  final void Function(Product) onDelete;

  SearchPage({
    required this.products,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = widget.products.where((product) {
      final lowerQuery = query.toLowerCase();
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.code.toLowerCase().contains(lowerQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Buscar Produtos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar por nome ou código',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Card(
                    child: ListTile(
                      title: Text('${product.name}'),
                      subtitle: Text('Código: ${product.code}\nPreço: R\$${product.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.green),
                            onPressed: () => widget.onEdit(product),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(product),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar Exclusão'),
        content: Text('Deseja excluir o produto "${product.name}"?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Excluir', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              widget.onDelete(product);
            },
          ),
        ],
      ),
    );
  }
}