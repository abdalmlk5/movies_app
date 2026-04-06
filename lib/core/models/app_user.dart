import 'package:movies_app/core/models/movie_model.dart';

class AppUser {
  String userID, name, email, password, phone;
  int avatarID;
  List<MovieModel> watchList;
  List<MovieModel> history;

  AppUser({
    this.userID = '',
    this.name = '',
    required this.email,
    required this.password,
    this.phone = '',
    this.avatarID = 1,
    this.watchList = const [],
    this.history = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "avatarID": avatarID,
      "watchList": watchList.map((movie) => movie.toJson()).toList(),
      "history": history.map((movie) => movie.toJson()).toList(),
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    final watchListJson = json["watchList"] as List?;
    final historyJson = json["history"] as List?;

    return AppUser(
      userID: json["userID"] ?? '',
      name: json["name"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
      phone: json["phone"] ?? '',
      avatarID: json["avatarID"] ?? 1,
      watchList: watchListJson != null
          ? watchListJson
              .map((item) => MovieModel.fromJson(Map<String, dynamic>.from(item)))
              .toList()
          : [],
      history: historyJson != null
          ? historyJson
              .map((item) => MovieModel.fromJson(Map<String, dynamic>.from(item)))
              .toList()
          : [],
    );
  }
}
