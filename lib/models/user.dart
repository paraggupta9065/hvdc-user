class User {
  int id;
  String username;
  String firstName;
  String lastName;
  String name;
  String? phone;
  int? otp;
  String? profilePic;
  String email;
  String googleId;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.phone,
    required this.otp,
    required this.profilePic,
    required this.email,
    required this.googleId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      name: json['name'],
      phone: json['phone'],
      otp: json['otp'],
      profilePic: json['profile_pic'],
      email: json['email'],
      googleId: json['google_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['name'] = name;
    data['phone'] = phone;
    data['otp'] = otp;
    data['profile_pic'] = profilePic;
    data['email'] = email;
    data['google_id'] = googleId;
    return data;
  }
}
