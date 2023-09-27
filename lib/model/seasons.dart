class Seasons {
  final String season_name;
  final int postId;

  Seasons({
    required this.season_name,
    required this.postId
  });

  factory Seasons.fromJson(Map<String, dynamic> json) {
    return Seasons(
      postId: json['postId'],
      season_name: json['season_name'],
    );
  }
}