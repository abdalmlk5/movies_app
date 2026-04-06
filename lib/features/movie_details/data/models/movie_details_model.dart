import '../../../../../core/models/movie_model.dart';

class MovieDetailsModel {
  final int id;
  final String title;
  final String descriptionFull;
  final String mediumCoverImage;
  final String backgroundImage;
  final double rating;
  final int year;
  final int runtime;
  final List<CastModel> cast;
  final List<String> screenshots;
  final List<MovieModel> similarMovies;
  final List<dynamic> genres; // أضفنا الـ Genres هنا

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.descriptionFull,
    required this.mediumCoverImage,
    required this.backgroundImage,
    required this.rating,
    required this.year,
    required this.runtime,
    required this.cast,
    required this.screenshots,
    required this.similarMovies,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(
      Map<String, dynamic> json, List<MovieModel> similar) {
    // تجميع الصور السكرين شوت
    List<String> screenshotUrls = [];
    if (json['large_screenshot_image1'] != null)
      screenshotUrls.add(json['large_screenshot_image1']);
    if (json['large_screenshot_image2'] != null)
      screenshotUrls.add(json['large_screenshot_image2']);
    if (json['large_screenshot_image3'] != null)
      screenshotUrls.add(json['large_screenshot_image3']);

    return MovieDetailsModel(
      id: json['id'],
      title: json['title'] ?? "",
      descriptionFull: json['description_full'] ?? "",
      mediumCoverImage: json['medium_cover_image'] ?? "",
      backgroundImage: json['background_image'] ?? "",
      rating: (json['rating'] as num).toDouble(),
      year: json['year'] ?? 0,
      runtime: json['runtime'] ?? 0,
      screenshots: screenshotUrls,
      similarMovies: similar,
      genres: json['genres'] ?? [],
      cast: (json['cast'] as List?)
              ?.map((actor) => CastModel.fromJson(actor))
              .toList() ??
          [],
    );
  }
}

class CastModel {
  final String name;
  final String characterName;
  final String? urlSmallImage;

  CastModel(
      {required this.name, required this.characterName, this.urlSmallImage});

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? "",
      characterName: json['character_name'] ?? "",
      urlSmallImage: json['url_small_image'],
    );
  }
}
