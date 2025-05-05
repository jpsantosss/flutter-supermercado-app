import 'package:flutter/material.dart';
import 'product.dart';

class ProductForm extends StatefulWidget {
  final Function(Product) onProductAdded;
  final Product? existingProduct;

  const ProductForm({
    Key? key,
    required this.onProductAdded,
    this.existingProduct,
  }) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    final product = widget.existingProduct;
    _nameController = TextEditingController(text: product?.name ?? '');
    _codeController = TextEditingController(text: product?.code ?? '');
    _priceController = TextEditingController(
      text: product != null ? product.price.toStringAsFixed(2) : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final code = _codeController.text.trim();
      final price = double.parse(_priceController.text.trim());

      final product = Product(name: name, code: code, price: price);

      widget.onProductAdded(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingProduct != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Produto' : 'Cadastrar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome:'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Informe o nome do produto' : null,
              ),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Código:'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Informe o código do produto' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Preço:'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  if (parsed == null || parsed < 0) {
                    return 'Informe um preço válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text(isEditing ? 'Salvar Alterações' : 'Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
