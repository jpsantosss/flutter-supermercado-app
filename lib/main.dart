import 'package:flutter/material.dart';
import 'product.dart';
import 'search_page.dart';
import 'payment_page.dart';
import 'product_form.dart';
import 'home_page.dart';
import 'footer.dart';

void main() {
  runApp(SupermarketApp());
}

class SupermarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supermercado',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
      home: HomeNavigation(),
    );
  }
}

class HomeNavigation extends StatefulWidget {
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _currentIndex = 0;

  final List<Product> _products = [
    Product(name: 'Arroz', code: '001', price: 5.0),
    Product(name: 'Feijão', code: '002', price: 6.5),
    Product(name: 'Macarrão', code: '003', price: 4.75),
  ];

  @override
  Widget build(BuildContext context) {
    // Atualiza as páginas dinamicamente
    List<Widget> _pages = [
      HomePage(),
      SearchPage(
        products: _products,
        onEdit: _editProduct,
        onDelete: _deleteProduct,
      ),
      Container(), // Placeholder para o botão de cadastro
      PaymentPage(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index == 2) {
                // Abrir o formulário via push
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductForm(
                      onProductAdded: (product) {
                        setState(() {
                          final i = _products
                              .indexWhere((p) => p.code == product.code);
                          if (i != -1) {
                            _products[i] = product;
                          } else {
                            _products.add(product);
                          }
                          _currentIndex = 1; // Voltar para aba de busca
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              } else {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Buscar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box), label: 'Cadastrar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.payment), label: 'Pagamento'),
            ],
          ),
          buildFooter(),
        ],
      ),
    );
  }

  void _editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductForm(
          existingProduct: product,
          onProductAdded: (updatedProduct) {
            setState(() {
              final index = _products.indexWhere((p) => p.code == product.code);
              if (index != -1) {
                _products[index] = updatedProduct;
              }
              _currentIndex = 1; // volta para a aba de busca
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _deleteProduct(Product product) {
    setState(() {
      _products.removeWhere((p) => p.code == product.code);
      _currentIndex = 1; // Atualiza visual para a aba de busca
    });
  }
}
