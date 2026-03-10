// "name":"abd",
// "email":"abd@gmail.com",
// "password":"abd123@",
// "confirmPassword":"abd123@",
// "phone":"+201127109260",
// "avatarId":1

class AppUser {
  String userID, email, password;

  AppUser({
    this.userID = '',
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "email": email,
      "password": password,
    };
  }

  AppUser.fromJson(Map<String, dynamic> json)
      : this(
          userID: json["userID"],
          email: json["email"],
          password: json["password"],
        );
}
