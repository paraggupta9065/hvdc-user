class Address {
  final int id;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdOn;
  final DateTime updatedOn;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final int createdBy;

  Address({
    required this.id,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
    required this.updatedOn,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.createdBy,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      isActive: json['is_active'],
      isDeleted: json['is_delete'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_active': isActive,
      'is_delete': isDeleted,
      'created_on': createdOn.toIso8601String(),
      'updated_on': updatedOn.toIso8601String(),
      'street': street,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'created_by': createdBy,
    };
  }
}
