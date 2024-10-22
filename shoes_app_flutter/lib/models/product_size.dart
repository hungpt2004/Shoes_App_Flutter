import 'package:flutter_shoes_shop/data/sql_helper.dart';
import 'package:flutter_shoes_shop/models/size.dart';

class ProductSize {
  final int productSizeId;
  final int price;
  final int amount;
  final int sizeId;
  final int productColorId;

  ProductSize({
    required this.productSizeId,
    required this.price,
    required this.amount,
    required this.sizeId,
    required this.productColorId,
  });

  // Chuyển đổi từ Map thành đối tượng ProductSize
  factory ProductSize.fromMap(Map<String, dynamic> map) {
    return ProductSize(
      productSizeId: map['Product_Size_ID'],
      price: map['Price'],
      amount: map['Amount'],
      sizeId: map['Size_ID'],
      productColorId: map['Product_Color_ID'],
    );
  }

  // Phương thức lấy thông tin Size dựa trên Size_ID
  Future<Size?> getSizeBySizeId() async {
    // Giả sử getSizeById là một hàm tĩnh từ một lớp khác, bạn gọi nó để lấy dữ liệu
    return await DBHelper.getSizeById(sizeId);
  }
}
