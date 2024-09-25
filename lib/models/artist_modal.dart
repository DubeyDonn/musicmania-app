class ArtistModal {
  final String name;
  final String imageUrl;
  final String id;
  final String genres;
  final List<String> albums;
  final List<String> followers;

  ArtistModal({
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.genres,
    required this.albums,
    required this.followers,
  });

  factory ArtistModal.fromJson(Map<dynamic, dynamic> json) {
    return ArtistModal(
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      id: json['id'] as String? ?? '',
      genres: json['genres'] as String? ?? '',
      albums: json['albums'] as List<String>? ?? [],
      followers: json['followers'] as List<String>? ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'id': id,
      'genres': genres,
      'albums': albums,
      'followers': followers,
    };
  }
}
