class Product {
  int productId;
  String name;
  String description;
  int shopId;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.shopId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'shopId': shopId,
    };
  }

  // Hàm tạo để chuyển đổi từ Map (cấu trúc dữ liệu trong SQLite) sang đối tượng Product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['Product_ID'],
      name: map['Name'],
      description: map['Description'],
      shopId: map['Brand_ID'],
    );
  }
  @override
  String toString() {
    return 'Product{productId: $productId, name: $name, description: $description, shopId: $shopId}';
  }
}
