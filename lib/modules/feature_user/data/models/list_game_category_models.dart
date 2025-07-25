import 'dart:convert';

class ListGameCategory {
    final int id;
    final String title;
    final String thumbnail;
    final String shortDescription;
    final String gameUrl;
    final String genre;
    final String platform;
    final String publisher;
    final String developer;
    final String releaseDate;
    final String freetogameProfileUrl;

    ListGameCategory({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.shortDescription,
        required this.gameUrl,
        required this.genre,
        required this.platform,
        required this.publisher,
        required this.developer,
        required this.releaseDate,
        required this.freetogameProfileUrl,
    });

    factory ListGameCategory.fromRawJson(String str) => ListGameCategory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListGameCategory.fromJson(Map<String, dynamic> json) => ListGameCategory(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: json["release_date"],
        freetogameProfileUrl: json["freetogame_profile_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "short_description": shortDescription,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date": releaseDate,
        "freetogame_profile_url": freetogameProfileUrl,
    };
}
