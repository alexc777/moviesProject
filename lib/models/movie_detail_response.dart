import 'dart:convert';

class MovieDetailResponse {
  MovieDetailResponse({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int runtime;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory MovieDetailResponse.fromJson(String str) => MovieDetailResponse.fromMap(json.decode(str));

  factory MovieDetailResponse.fromMap(Map<String, dynamic> json) => MovieDetailResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    budget: json["budget"],
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
    homepage: json["homepage"],
    id: json["id"],
    imdbId: json["imdb_id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    productionCompanies: List<ProductionCompany>.from(json["production_companies"].map((x) => ProductionCompany.fromMap(x))),
    productionCountries: List<ProductionCountry>.from(json["production_countries"].map((x) => ProductionCountry.fromMap(x))),
    releaseDate: DateTime.parse(json["release_date"]),
    revenue: json["revenue"],
    runtime: json["runtime"],
    status: json["status"],
    tagline: json["tagline"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  int id;
  String? logoPath;
  String name;
  String originCountry;

  get logoImg {
    if(this.logoPath != null)
      return 'https://image.tmdb.org/t/p/w200${ this.logoPath }';
    
    return 'https://i.stack.imgur.com/GNhxO.png';
  }
  
  get bannerCompanie {
    if(this.logoPath != null)
      return 'https://image.tmdb.org/t/p/w500${ this.logoPath }';
    
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory ProductionCompany.fromJson(String str) => ProductionCompany.fromMap(json.decode(str));

  factory ProductionCompany.fromMap(Map<String, dynamic> json) => ProductionCompany(
    id: json["id"],
    logoPath: json["logo_path"] == null ? null : json["logo_path"],
    name: json["name"],
    originCountry: json["origin_country"],
  );
}

class ProductionCountry {
  ProductionCountry({
      required this.iso31661,
      required this.name,
  });

  String iso31661;
  String name;

  factory ProductionCountry.fromJson(String str) => ProductionCountry.fromMap(json.decode(str));

  factory ProductionCountry.fromMap(Map<String, dynamic> json) => ProductionCountry(
    iso31661: json["iso_3166_1"],
    name: json["name"],
  );
}
