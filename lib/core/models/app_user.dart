// "name":"abd",
// "email":"abd@gmail.com",
// "password":"abd123@",
// "confirmPassword":"abd123@",
// "phone":"+201127109260",
// "avatarId":1

class AppUser {
  String userID, email, password;
  int avatarID;

  AppUser(
      {this.userID = '',
      required this.email,
      required this.password,
      this.avatarID = 0});

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "email": email,
      "password": password,
      "avatarID": avatarID
    };
  }

  AppUser.fromJson(Map<String, dynamic> json)
      : this(
            userID: json["userID"],
            email: json["email"],
            password: json["password"],
            avatarID: json["avatarID"]);
}
