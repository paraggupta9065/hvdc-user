class BannerModel {
  final int id;
  final bool isActive;
  final bool isDelete;
  final DateTime createdOn;
  final DateTime updatedOn;
  final String title;
  final String image;
  final String link;
  final DateTime createdAt;

  const BannerModel({
    required this.id,
    required this.isActive,
    required this.isDelete,
    required this.createdOn,
    required this.updatedOn,
    required this.title,
    required this.image,
    required this.link,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int,
      isActive: json['is_active'] as bool,
      isDelete: json['is_delete'] as bool,
      createdOn: DateTime.parse(json['created_on'] as String),
      updatedOn: DateTime.parse(json['updated_on'] as String),
      title: json['title'] as String,
      image: json['image'] as String,
      link: json['link'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
