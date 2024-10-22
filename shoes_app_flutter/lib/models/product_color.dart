class ProductColor {
  final int id;
  final int colorId;
  final int productId;
  final String urlImage;

  ProductColor({
    required this.id,
    required this.colorId,
    required this.productId,
    required this.urlImage,
  });

  // Chuyển đổi từ Map (SQLite query result) sang ProductColor
  factory ProductColor.fromMap(Map<String, dynamic> map) {
    return ProductColor(
      id: map['Product_Color_ID'],
      colorId: map['Color_ID'],
      productId: map['Product_ID'],
      urlImage: map['Url_Image'],
    );
  }
}
