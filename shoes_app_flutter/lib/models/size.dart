class Size {
  int sizeId;
  String size;

  Size({
    required this.sizeId,
    required this.size,
  });

  // Chuyển đổi từ Map thành đối tượng Size
  factory Size.fromMap(Map<String, dynamic> map) {
    return Size(
      sizeId: map['Size_ID'],
      size: map['Size'],
    );
  }
}