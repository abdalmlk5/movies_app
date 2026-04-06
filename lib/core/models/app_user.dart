class AppUser {
  String userID, name, email, password, phone;
  int avatarID;

  AppUser({
    this.userID = '',
    this.name = '',
    required this.email,
    required this.password,
    this.phone = '',
    this.avatarID = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "avatarID": avatarID
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      userID: json["userID"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      phone: json["phone"] ?? '',
      avatarID: json["avatarID"] ?? 1,
    );
  }
}
