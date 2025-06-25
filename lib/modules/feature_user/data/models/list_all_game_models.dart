import 'dart:convert';

class ListAllGame {
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

    ListAllGame({
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

    factory ListAllGame.fromRawJson(String str) => ListAllGame.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListAllGame.fromJson(Map<String, dynamic> json) => ListAllGame(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        thumbnail: json["thumbnail"] ?? '',
        shortDescription: json["short_description"] ?? '',
        gameUrl: json["game_url"] ?? '',
        genre: json["genre"] ?? '',
        platform: json["platform"] ?? '',
        publisher: json["publisher"] ?? '',
        developer: json["developer"] ?? '',
        releaseDate: json["release_date"] ?? '',
        freetogameProfileUrl: json["freetogame_profile_url"] ?? '',
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
