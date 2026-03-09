class MovieModel {
  final int id;
  final String title;
  final String mediumCoverImage;
  final double rating;

  MovieModel({required this.id, required this.title, required this.mediumCoverImage, required this.rating});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      mediumCoverImage: json['medium_cover_image'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}