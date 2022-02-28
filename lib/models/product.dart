import 'dart:ffi';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final Float price;
  final String sku;
  final int categoryId;
  final int destributorId;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.sku,
      required this.categoryId,
      required this.destributorId});
}
