class DetailListGame {
    DetailListGame({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.status,
        required this.shortDescription,
        required this.description,
        required this.gameUrl,
        required this.genre,
        required this.platform,
        required this.publisher,
        required this.developer,
        required this.releaseDate,
        required this.freetogameProfileUrl,
        required this.minimumSystemRequirements,
        required this.screenshots,
    });

    final int? id;
    final String? title;
    final String? thumbnail;
    final String? status;
    final String? shortDescription;
    final String? description;
    final String? gameUrl;
    final String? genre;
    final String? platform;
    final String? publisher;
    final String? developer;
    final DateTime? releaseDate;
    final String? freetogameProfileUrl;
    final MinimumSystemRequirements? minimumSystemRequirements;
    final List<Screenshot> screenshots;

    factory DetailListGame.fromJson(Map<String, dynamic> json){ 
        return DetailListGame(
            id: json["id"],
            title: json["title"],
            thumbnail: json["thumbnail"],
            status: json["status"],
            shortDescription: json["short_description"],
            description: json["description"],
            gameUrl: json["game_url"],
            genre: json["genre"],
            platform: json["platform"],
            publisher: json["publisher"],
            developer: json["developer"],
            releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
            freetogameProfileUrl: json["freetogame_profile_url"],
            minimumSystemRequirements: json["minimum_system_requirements"] == null ? null : MinimumSystemRequirements.fromJson(json["minimum_system_requirements"]),
            screenshots: json["screenshots"] == null ? [] : List<Screenshot>.from(json["screenshots"]!.map((x) => Screenshot.fromJson(x))),
        );
    }

}

class MinimumSystemRequirements {
    MinimumSystemRequirements({
        required this.os,
        required this.processor,
        required this.memory,
        required this.graphics,
        required this.storage,
    });

    final String? os;
    final String? processor;
    final String? memory;
    final String? graphics;
    final String? storage;

    factory MinimumSystemRequirements.fromJson(Map<String, dynamic> json){ 
        return MinimumSystemRequirements(
            os: json["os"],
            processor: json["processor"],
            memory: json["memory"],
            graphics: json["graphics"],
            storage: json["storage"],
        );
    }

}

class Screenshot {
    Screenshot({
        required this.id,
        required this.image,
    });

    final int? id;
    final String? image;

    factory Screenshot.fromJson(Map<String, dynamic> json){ 
        return Screenshot(
            id: json["id"],
            image: json["image"],
        );
    }

}