class Order {
  int id;
  List<Test> tests;
  Address address;
  Patient patient;
  Slot? slot;
  DateTime dateAdded;
  String status;
  int user;
  int total_price;

  Order({
    required this.id,
    required this.tests,
    required this.address,
    required this.patient,
    required this.slot,
    required this.dateAdded,
    required this.status,
    required this.user,
    required this.total_price,
  });

  Order copyWith({
    int? id,
    List<Test>? tests,
    Address? address,
    Patient? patient,
    Slot? slot,
    DateTime? dateAdded,
    String? status,
    int? user,
    int? total_price,
  }) =>
      Order(
        id: id ?? this.id,
        tests: tests ?? this.tests,
        address: address ?? this.address,
        patient: patient ?? this.patient,
        slot: slot ?? this.slot,
        dateAdded: dateAdded ?? this.dateAdded,
        status: status ?? this.status,
        user: user ?? this.user,
        total_price: total_price ?? 0,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        tests: List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
        address: Address.fromJson(json["address"]),
        patient: Patient.fromJson(json["patient"]),
        slot: json["slot"] == null ? null : Slot.fromJson(json["slot"]),
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
        user: json["user"],
        total_price: json["total_price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tests": List<dynamic>.from(tests.map((x) => x.toJson())),
        "address": address.toJson(),
        "patient": patient.toJson(),
        "slot": slot?.toJson(),
        "date_added": dateAdded.toIso8601String(),
        "status": status,
        "user": user,
      };
}

class Address {
  int id;
  bool isActive;
  bool isDelete;
  DateTime createdOn;
  DateTime updatedOn;
  String street;
  String city;
  String state;
  String postalCode;
  int createdBy;

  Address({
    required this.id,
    required this.isActive,
    required this.isDelete,
    required this.createdOn,
    required this.updatedOn,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.createdBy,
  });

  Address copyWith({
    int? id,
    bool? isActive,
    bool? isDelete,
    DateTime? createdOn,
    DateTime? updatedOn,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    int? createdBy,
  }) =>
      Address(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        isDelete: isDelete ?? this.isDelete,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
        street: street ?? this.street,
        city: city ?? this.city,
        state: state ?? this.state,
        postalCode: postalCode ?? this.postalCode,
        createdBy: createdBy ?? this.createdBy,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        isActive: json["is_active"],
        isDelete: json["is_delete"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        street: json["street"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "street": street,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "created_by": createdBy,
      };
}

class Patient {
  int id;
  bool isActive;
  bool isDelete;
  DateTime createdOn;
  DateTime updatedOn;
  String name;
  String gender;
  String phoneNumber;
  int createdBy;

  Patient({
    required this.id,
    required this.isActive,
    required this.isDelete,
    required this.createdOn,
    required this.updatedOn,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.createdBy,
  });

  Patient copyWith({
    int? id,
    bool? isActive,
    bool? isDelete,
    DateTime? createdOn,
    DateTime? updatedOn,
    String? name,
    String? gender,
    String? phoneNumber,
    int? createdBy,
  }) =>
      Patient(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        isDelete: isDelete ?? this.isDelete,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        createdBy: createdBy ?? this.createdBy,
      );

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        isActive: json["is_active"],
        isDelete: json["is_delete"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        name: json["name"],
        gender: json["gender"],
        phoneNumber: json["phone_number"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "name": name,
        "gender": gender,
        "phone_number": phoneNumber,
        "created_by": createdBy,
      };
}

class Slot {
  int id;
  int day;
  int month;
  int year;
  int hour;
  int minute;
  int pathology;

  Slot({
    required this.id,
    required this.day,
    required this.month,
    required this.year,
    required this.hour,
    required this.minute,
    required this.pathology,
  });

  Slot copyWith({
    int? id,
    int? day,
    int? month,
    int? year,
    int? hour,
    int? minute,
    int? pathology,
  }) =>
      Slot(
        id: id ?? this.id,
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        pathology: pathology ?? this.pathology,
      );

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        hour: json["hour"],
        minute: json["minute"],
        pathology: json["pathology"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "month": month,
        "year": year,
        "hour": hour,
        "minute": minute,
        "pathology": pathology,
      };
}

class Test {
  int id;
  bool inCart;
  String name;
  String description;
  String testType;
  int regularPrice;
  int price;
  bool isOffline;
  int pathology;
  int category;
  List<int> pathologyList;

  Test({
    required this.id,
    required this.inCart,
    required this.name,
    required this.description,
    required this.testType,
    required this.regularPrice,
    required this.price,
    required this.isOffline,
    required this.pathology,
    required this.category,
    required this.pathologyList,
  });

  Test copyWith({
    int? id,
    bool? inCart,
    String? name,
    String? description,
    String? testType,
    int? regularPrice,
    int? price,
    bool? isOffline,
    int? pathology,
    int? category,
    List<int>? pathologyList,
  }) =>
      Test(
        id: id ?? this.id,
        inCart: inCart ?? this.inCart,
        name: name ?? this.name,
        description: description ?? this.description,
        testType: testType ?? this.testType,
        regularPrice: regularPrice ?? this.regularPrice,
        price: price ?? this.price,
        isOffline: isOffline ?? this.isOffline,
        pathology: pathology ?? this.pathology,
        category: category ?? this.category,
        pathologyList: pathologyList ?? this.pathologyList,
      );

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["id"],
        inCart: json["in_cart"],
        name: json["name"],
        description: json["description"],
        testType: json["test_type"],
        regularPrice: json["regular_price"],
        price: json["price"],
        isOffline: json["is_offline"],
        pathology: json["pathology"],
        category: json["category"],
        pathologyList: List<int>.from(json["pathology_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "in_cart": inCart,
        "name": name,
        "description": description,
        "test_type": testType,
        "regular_price": regularPrice,
        "price": price,
        "is_offline": isOffline,
        "pathology": pathology,
        "category": category,
        "pathology_list": List<dynamic>.from(pathologyList.map((x) => x)),
      };
}
