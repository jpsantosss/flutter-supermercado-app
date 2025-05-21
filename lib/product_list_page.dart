import 'package:flutter/material.dart';
import 'product.dart';
import 'product_form.dart';
import 'product_storage.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> _products = [];
  final _storage = ProductStorage();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    final loaded = await _storage.loadProducts();
    setState(() {
      _products = loaded;
    });
  }

  void _addOrUpdateProduct(Product product) {
    setState(() {
      final index = _products.indexWhere((p) => p.code == product.code);
      if (index >= 0) {
        _products[index] = product;
      } else {
        _products.add(product);
      }
    });
    _storage.saveProducts(_products);
  }

  void _deleteProduct(String code) {
    setState(() {
      _products.removeWhere((product) => product.code == code);
    });
    _storage.saveProducts(_products);
  }

  void _navigateToForm({Product? product}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductForm(
          onProductAdded: _addOrUpdateProduct,
          existingProduct: product,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Produtos')),
      body: _products.isEmpty
          ? Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(
                      'Código: ${product.code} - R\$ ${product.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _navigateToForm(product: product),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(product.code),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
