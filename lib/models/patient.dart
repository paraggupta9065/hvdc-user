class Patient {
  final int id;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdOn;
  final DateTime updatedOn;
  final String name;
  final String gender;
  final String phoneNumber;
  final int createdBy;

  Patient({
    required this.id,
    required this.isActive,
    required this.isDeleted,
    required this.createdOn,
    required this.updatedOn,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.createdBy,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      isActive: json['is_active'],
      isDeleted: json['is_delete'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
      name: json['name'],
      gender: json['gender'],
      phoneNumber: json['phone_number'],
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
      'name': name,
      'gender': gender,
      'phone_number': phoneNumber,
      'created_by': createdBy,
    };
  }
}
