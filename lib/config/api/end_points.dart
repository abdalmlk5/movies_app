class EndPoints {
  EndPoints._();

  // Base URL:
  static const String baseUrl = "https://yts.mx/api/v2";

  // API EndPoints:
  static const String listMovies = "$baseUrl/list_movies";

  static const String movieDetails = "$baseUrl/movie_details";

  static const String movieSuggestions = "$baseUrl/movie_suggestions";
}
