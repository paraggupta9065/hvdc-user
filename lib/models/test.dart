class Test {
  int id;
  String name;
  String description;
  String testType;
  double regularPrice;
  double price;
  bool isOffline;
  int pathology;
  int category;

  Test({
    required this.id,
    required this.name,
    required this.description,
    required this.testType,
    required this.regularPrice,
    required this.price,
    required this.isOffline,
    required this.pathology,
    required this.category,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      testType: json['test_type'],
      regularPrice: json['regular_price'] != null
          ? json['regular_price'].toDouble()
          : null,
      price: json['price'] != null ? json['price'].toDouble() : null,
      isOffline: json['is_offline'] ?? false,
      pathology: json['pathology'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['test_type'] = testType;
    data['regular_price'] = regularPrice;
    data['price'] = price;
    data['is_offline'] = isOffline;
    data['pathology'] = pathology;
    data['category'] = category;
    return data;
  }
}
