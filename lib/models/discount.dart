import 'dart:ffi';

class DiscountModel {
  final int id;
  final int productId;
  final Float discountPercent;
  final Bool active;
  DiscountModel(
      {required this.id,
      required this.productId,
      required this.discountPercent,
      required this.active});
}
