class Product {
  String name;
  String code;
  double price;

  Product({required this.name, required this.code, required this.price});

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'price': price,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json['name'],
        code: json['code'],
        price: (json['price'] as num).toDouble(),
      );
}
