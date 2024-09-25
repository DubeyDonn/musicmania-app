class SongModel {
  final String id;
  final String name;
  final Map<String, dynamic> album;
  final Map<String, dynamic> artist;
  final int duration;
  final String artworkImage;
  final int popularity;
  final String language;
  final String fileName;
  final int version;

  SongModel({
    required this.id,
    required this.name,
    required this.album,
    required this.artist,
    required this.duration,
    required this.artworkImage,
    required this.popularity,
    required this.language,
    required this.fileName,
    required this.version,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      album: json['album'] as Map<String, dynamic>,
      artist: json['artist'] as Map<String, dynamic>,
      duration: json['duration'] as int,
      artworkImage: json['artworkImage'] as String,
      popularity: json['popularity'] as int,
      language: json['language'] as String,
      fileName: json['fileName'] as String,
      version: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'album': album,
      'artist': artist,
      'duration': duration,
      'artworkImage': artworkImage,
      'popularity': popularity,
      'language': language,
      'fileName': fileName,
      '__v': version,
    };
  }
}
