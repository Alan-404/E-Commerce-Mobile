class BannerModel {
  final int id;
  final String image;
  final int distributorId;

  BannerModel(
      {required this.id, required this.image, required this.distributorId});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
        id: json['id'],
        image: json['image'],
        distributorId: json['distributor_d']);
  }
}
