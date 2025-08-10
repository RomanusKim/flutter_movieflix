class MovieModel {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
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

  // MovieModel.fromJson(Map<String, dynamic> json)
  //   : adult = json['adult'],
  //     backdropPath = json['backdropPath'],
  //     genreIds = json['genreIds'],
  //     id = json['id'],
  //     originalLanguage = json['originalLanguage'],
  //     originalTitle = json['originalTitle'],
  //     overview = json['overview'],
  //     popularity = json['popularity'],
  //     posterPath = json['posterPath'],
  //     releaseDate = json['releaseDate'],
  //     title = json['title'],
  //     video = json['video'],
  //     voteAverage = json['voteAverage'],
  //     voteCount = json['voteCount'];

  MovieModel.fromJson(Map<String, dynamic> json)
    : adult = (json['adult'] as bool?) ?? false,
      backdropPath = (json['backdrop_path'] ?? '').toString(),
      genreIds = ((json['genre_ids'] as List?) ?? const []).map((e) => (e as num).toInt()).toList(),
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



// {
//   "adult": false,
//   "backdrop_path": "/wSy4EZlZcbxyoLS5jQk5Vq3Az8.jpg",
//   "genre_ids": [878, 53],
//   "id": 755898,
//   "original_language": "en",
//   "original_title": "War of the Worlds",
//   "overview": "Will Radford is a top analyst for Homeland Security who tracks potential threats through a mass surveillance program, until one day an attack by an unknown entity leads him to question whether the government is hiding something from him... and from the rest of the world.",
//   "popularity": 2226.0499,
//   "poster_path": "/yvirUYrva23IudARHn3mMGVxWqM.jpg",
//   "release_date": "2025-07-29",
//   "title": "War of the Worlds",
//   "video": false,
//   "vote_average": 4.485,
//   "vote_count": 201
// }