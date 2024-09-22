import 'dart:convert';

class MovieDetail {
  final bool adult;
  final String backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromRawJson(String str) =>
      MovieDetail.fromJson(json.decode(str));

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"] ?? 0,
        genres: List<Genre>.from(
            json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"] ?? '',
        id: json["id"] ?? 0,
        imdbId: json["imdb_id"] ?? '',
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        popularity: (json["popularity"] ?? 0).toDouble(),
        posterPath: json["poster_path"] ?? '',
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"].map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"].map((x) => ProductionCountry.fromJson(x))),
        releaseDate: json["release_date"] ?? '',
        revenue: json["revenue"] ?? 0,
        runtime: json["runtime"] ?? 0,
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"] ?? '',
        tagline: json["tagline"] ?? '',
        title: json["title"] ?? '',
        video: json["video"] ?? false,
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
        voteCount: json["vote_count"] ?? 0,
      );
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );
}

class ProductionCompany {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromRawJson(String str) =>
      ProductionCompany.fromJson(json.decode(str));

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"] ?? 0,
        logoPath: json["logo_path"] ?? '',
        name: json["name"] ?? '',
        originCountry: json["origin_country"] ?? '',
      );
}

class ProductionCountry {
  final String iso3166_1;
  final String name;

  ProductionCountry({
    required this.iso3166_1,
    required this.name,
  });

  factory ProductionCountry.fromRawJson(String str) =>
      ProductionCountry.fromJson(json.decode(str));

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso3166_1: json["iso_3166_1"] ?? '',
        name: json["name"] ?? '',
      );
}

class SpokenLanguage {
  final String englishName;
  final String iso639_1;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso639_1,
    required this.name,
  });

  factory SpokenLanguage.fromRawJson(String str) =>
      SpokenLanguage.fromJson(json.decode(str));

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      SpokenLanguage(
        englishName: json["english_name"] ?? '',
        iso639_1: json["iso_639_1"] ?? '',
        name: json["name"] ?? '',
      );
}
