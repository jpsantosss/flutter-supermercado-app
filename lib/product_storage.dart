import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'product.dart';

class ProductStorage {
  static const _fileName = 'produtos.json';

  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  Future<File> _getFile() async {
    final path = await _getFilePath();
    return File(path);
  }

  Future<List<Product>> loadProducts() async {
    try {
      final file = await _getFile();
      if (file.existsSync()) {
        final content = await file.readAsString();
        final List<dynamic> jsonList = json.decode(content);
        return jsonList.map((item) => Product.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> saveProducts(List<Product> products) async {
    final file = await _getFile();
    final jsonList = products.map((p) => p.toJson()).toList();
    final content = json.encode(jsonList);
    await file.writeAsString(content);
  }
}
