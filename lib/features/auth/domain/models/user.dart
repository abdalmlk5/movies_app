// "name":"abd",
// "email":"abd@gmail.com",
// "password":"abd123@",
// "confirmPassword":"abd123@",
// "phone":"+201127109260",
// "avatarId":1

class User {
  String name, email, password, confirmPassword, phone;
  int avatarId;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avatarId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": phone,
      "avaterId": avatarId,
    };
  }

  User.fromJson(Map<String, dynamic> json)
      : this(
          name: json["name"],
          email: json["email"],
          password: json["password"],
          confirmPassword: json["confirmPassword"],
          phone: json["phone"],
          avatarId: json["avaterId"],
        );
}
