class Category {
  final int id;
  final bool isActive;
  final bool isDelete;
  final DateTime createdOn;
  final DateTime updatedOn;
  final String categoryName;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String image;

  Category({
    required this.id,
    required this.isActive,
    required this.isDelete,
    required this.createdOn,
    required this.updatedOn,
    required this.categoryName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      isActive: json['is_active'] as bool,
      isDelete: json['is_delete'] as bool,
      createdOn: DateTime.parse(json['created_on'] as String),
      updatedOn: DateTime.parse(json['updated_on'] as String),
      categoryName: json['category_name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      image: json['image'] as String,
    );
  }
}
