// class EndPoints {
//   EndPoints._();
//
//   // Base URL:
//   // static const String baseUrl = "https://yts.mx/api/v2";
//   static const String baseUrl = "https://yts.lt/api";
//
//   // API EndPoints:
//   static const String listMovies = "$baseUrl/list_movies";
//
//   static const String movieDetails = "$baseUrl/movie_details";
//
//   static const String movieSuggestions = "$baseUrl/movie_suggestions";
// }
//
class EndPoints {
  EndPoints._();


  static const String baseUrl = "https://movies-api.accel.li/api/v2/";

  // يجب إضافة .json في نهاية الرابط
  static const String listMovies = "$baseUrl/list_movies.json";

  static const String movieDetails = "https://movies-api.accel.li/api/v2/movie_details.json?";

  static const String movieSuggestions = "https://movies-api.accel.li/api/v2/movie_suggestions.json";

}
