class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final List<String> genres; // 항상 빈 리스트 이상 보장
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
    : adult = (json['adult'] as bool?) ?? false,
      backdropPath = (json['backdrop_path'] ?? '').toString(),
      // 상세 응답(genres) 우선, 없으면 genre_ids 매핑, 그래도 없으면 []
      genres = json['genres'] != null
          ? (((json['genres'] as List?) ?? const [])
                .map((e) => (e as Map<String, dynamic>)['name'])
                .where((name) => name != null && name.toString().isNotEmpty)
                .map((name) => name.toString())
                .toList())
          : [],
      id = (json['id'] as num?)?.toInt() ?? 0,
      originalLanguage = (json['original_language'] ?? '').toString(),
      originalTitle = (json['original_title'] ?? '').toString(),
      overview = (json['overview'] ?? '').toString(),
      popularity = (json['popularity'] is num)
          ? (json['popularity'] as num).toDouble()
          : double.tryParse(json['popularity']?.toString() ?? '') ?? 0.0,
      posterPath = (json['poster_path'] ?? '').toString(),
      releaseDate = (json['release_date'] ?? '').toString(),
      title = (json['title'] ?? '').toString(),
      video = (json['video'] as bool?) ?? false,
      voteAverage = (json['vote_average'] is num)
          ? (json['vote_average'] as num).toDouble()
          : double.tryParse(json['vote_average']?.toString() ?? '') ?? 0.0,
      voteCount = (json['vote_count'] as num?)?.toInt() ?? 0;
}
